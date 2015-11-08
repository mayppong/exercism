defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }
  def kind(a, b, c) do
    cond do
      negative_length(a, b, c) -> {:error, "all side lengths must be positive"}
      violate_triangle_equality(a, b, c) -> {:error, "side lengths violate triangle inequality"}
      is_scalene(a, b, c) -> {:ok, :scalene}
      is_equilateral(a, b, c) -> {:ok, :equilateral}
      is_isosceles(a, b, c) -> {:ok, :isosceles}
      true -> {:error, "Not a triangle"}
    end
  end

  def negative_length(a, b, c) do
    a <= 0 or b <= 0 or c <= 0
  end

  def violate_triangle_equality(a, b, c) do
    a + b <= c or b + c <= a or a + c <= b
  end

  def is_scalene(a, b, c) do
    a !== b and b !== c and a !== c
  end

  def is_equilateral(a, b, c) do
    a === b and b === c
  end

  def is_isosceles(a, b, c) do
    cond do
      a === b and a !== c -> true
      b === c and a !== b -> true
      a === c and a !== b -> true
      true -> false
    end
  end
end
