defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise ArgumentError
  def nth(count) do
    1..count
    |> Enum.reduce([], fn(_, acc) ->
      case acc do
        [] -> [next_prime(1)]
        [last | _] -> [next_prime(last) | acc]
        _ -> acc
      end
    end)
    |> hd
  end

  def next_prime(num) do
    next = num + 1
    case prime?(next) do
      true -> next
      false -> next_prime(next)
    end
  end

  def prime?(num) do
    factor = 2..num
    |> Enum.reject(fn(item) ->
      rem(num, item) !== 0
    end)

    factor === [num]
  end

end
