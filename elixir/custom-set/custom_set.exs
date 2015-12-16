defmodule CustomSet do
  # This lets the compiler check that all Set callback functions have been
  # implemented.
  @behaviour Set
  defstruct list: []

  def new(), do: %CustomSet{}
  def new(list) do
    %CustomSet{list: clean(list)}
  end

  def delete(set, item) do
    set.list
    |> Enum.reduce([], fn(current, acc) ->
      if current !== item do
        [current | acc]
      else
        acc
      end
    end)
    |> new
  end

  def difference(set_1, set_2) do
    set_1.list
    |> Enum.reduce([], fn(item, acc) ->
      if Enum.member?(set_2.list, item) do
        acc
      else
        [item | acc]
      end
    end)
    |> new
  end

  def disjoint?(set_1, set_2) do
    set_1.list
    |> Enum.reduce_while(true, fn(item, acc) ->
      if Enum.member?(set_2.list, item) do
        {:halt, false}
      else
        {:cont, acc}
      end
    end)
  end

  def empty(_) do
    new()
  end

  def equal?(set_1, set_2) do
    set_1 === set_2
  end

  def intersection(set_1, set_2) do
    set_1.list
    |> Enum.reduce([], fn(item, acc) ->
      if Enum.member?(set_2.list, item) do
        [item | acc]
      else
        acc
      end
    end)
    |> new
  end

  def member?(set, item) do
    Enum.member?(set.list, item)
  end

  def put(set, item) do
    [item | set.list]
    |> new
  end

  def size(set) do
    set.list
    |> Enum.count
  end

  def subset?(set_1, set_2) do
    set_1.list
    |> Enum.reduce_while(true, fn(item, acc) ->
      if Enum.member?(set_2.list, item) do
        {:cont, acc}
      else
        {:halt, false}
      end
    end)
  end

  def to_list(set) do
    set.list
  end

  def union(set_1, set_2) do
    set_1.list ++ set_2.list
    |> new
  end

  def clean(list) do
    list
    |> Enum.uniq
    |> Enum.sort
  end

  defimpl Inspect, for: CustomSet do
    def inspect(set, _) do
      "#<CustomSet #{inspect(set.list)}>"
    end
  end
end
