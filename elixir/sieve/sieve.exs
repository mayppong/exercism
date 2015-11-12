defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    collect(Enum.to_list(2..limit), [])
    |> Enum.reverse
  end

  def collect([], primes), do: primes
  def collect([potential | candidates], primes) do
    Enum.reject(candidates, fn(item) ->
      rem(item, potential) === 0
    end)
    |> collect([potential|primes])
  end

end
