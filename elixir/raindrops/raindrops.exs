defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    find_primes(number)
    |> speak(number)
  end

  def find_primes(number) do
    [3, 5, 7]
    |> Enum.filter(fn(item) ->
        rem(number, item) === 0
      end)
  end

  def speak([], fallback), do: Integer.to_string(fallback)
  def speak(primes, fallback) do
    Enum.reduce(primes, "", fn(item, acc) ->
      case item do
        3 -> acc <> "Pling"
        5 -> acc <> "Plang"
        7 -> acc <> "Plong"
        _ -> acc
      end
    end)
  end
end
