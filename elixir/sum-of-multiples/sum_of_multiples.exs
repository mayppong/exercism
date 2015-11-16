defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.

  The default factors are 3 and 5.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors \\ [3, 5]) do
    factors
    |> Enum.reduce([], fn(factor, acc) ->
      acc ++ multiples(limit, factor)
    end)
    |> Enum.uniq
    |> Enum.sum
  end

  def multiples(limit, factor) do
    1..(limit - 1)
    |> Enum.reduce([], fn(item, acc) ->
      case rem(item, factor) do
        0 -> [item | acc]
        _ -> acc
      end
    end)
  end
end
