defmodule Palindromes do

  @palin %{}

  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map() 
  def generate(max_factor, min_factor \\ 1) do
    for i <- min_factor..max_factor,
      j <- min_factor..i,
      palindrome?(i*j) do
        Enum.sort([i, j])
    end 
    |> Enum.group_by(fn([i,j]) -> i * j end)
  end

  @spec palindrome?(integer) :: boolean
  def palindrome?(integer) do
    string = Integer.to_string(integer)
    string === String.reverse(string)
  end
end
