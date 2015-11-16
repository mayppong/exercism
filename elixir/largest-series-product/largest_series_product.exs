defmodule Series do

  @doc """
  Splits up the given string of numbers into an array of integers.
  """
  @spec digits(String.t) :: [non_neg_integer]
  def digits(number_string) do
    number_string
    |> String.codepoints
    |> Enum.map(&String.to_integer/1)
  end

  @doc """
  Generates sublists of a given size from a given string of numbers.

  This method first slice the string into chunck first then convert them to
  array of integer instead of the other way around. Simply, I had the hunch
  that slicing array is easier than slicing array of integer to chunks.
  Nothing to back that thought up though.
  """
  @spec slices(String.t, non_neg_integer) :: [list(non_neg_integer)]
  def slices(number_string, size) do
    0..(String.length(number_string) - size)
    |> Enum.reduce([], fn(index, acc) ->
      [ String.slice(number_string, index, size) | acc ]
    end)
    |> Enum.map(&digits/1)
    |> Enum.reverse
  end

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(number_string, size) do
    slices(number_string, size)
    |> Enum.map(fn(slice) ->
      Enum.reduce(slice, 1, &(&1 * &2))
    end)
    |> Enum.max
  end
end
