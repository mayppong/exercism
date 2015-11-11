defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest. 
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    factors_for(number, 2)
  end

  def factors_for(1, divisor), do: [] 
  def factors_for(number, divisor) do
    cond do
      rem(number, divisor) === 0 -> 
        value = div(number, divisor)
        [ divisor | factors_for(value, divisor) ]
      true ->
        factors_for(number, divisor + 1)
    end
  end
end
