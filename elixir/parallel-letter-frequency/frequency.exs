defmodule Frequency do
  @doc """
  Count word frequency in parallel.

  Returns a dict of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: Dict.t
  def frequency([], _), do: %{}
  def frequency(texts, workers) do
    size = Enum.count(texts)
    pids = cond do
      workers > size -> size
      true -> workers
    end
    |> create_workers
    |> assign_work(texts)
    
    results = collect_results(texts)
    |> merge_results

    Enum.each(pids, fn (pid) -> send pid, :stop end)

    results
  end

  def count(counter, strings) do
    strings
    |> String.replace(~r/[^\p{L}]/iu, "")
    |> String.downcase
    |> String.split("", trim: true)
    |> Enum.reduce(counter, fn(char, acc) ->
      Map.update(acc, String.downcase(char), 1, fn(value) ->
        value + 1
      end)
    end)
  end

  def create_workers(qty) do
    parent_pid = self()
    Enum.map(1..qty, fn(_) -> 
      spawn(fn -> worker_do(parent_pid) end)
    end)
  end

  @doc """
  In case the same worker is expected to do more than one work, we redefine
  the receive again after the job is complete.
  """
  def worker_do(pid) do
    receive do
      {:count, text} ->
        send(pid, {:complete, Frequency.count(%{}, text)})
        worker_do(pid)
      _ ->
    end
  end

  def assign_work(workers, works) do
    size = Enum.count(works)
    workers
    |> Stream.cycle
    |> Enum.take(size)
    |> Enum.zip(works)
    |> Enum.each(fn({worker, work}) ->
      send worker, {:count, work}
    end)

    workers
  end

  def collect_results(works) do
    Enum.map(works, fn(_) ->
      receive do
        {:complete, result} -> result
        _ ->
      end
    end)
  end

  def merge_results(container) do
    Enum.reduce(container, fn(item, acc) ->
      Dict.merge(acc, item, fn(_, a, b) -> a + b end)
    end)
  end
end
