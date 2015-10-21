defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare([], [_]), do: :sublist
  def compare([_], []), do: :superlist
  def compare(a, b) do
    cond do
      a === b -> :equal
      is_sublist?(a, b) -> :sublist
      is_sublist?(b, a) -> :superlist
      true -> :unequal
    end
  end

  @doc """
  Check if list `b` contains list `a`
  """
  def is_sublist?(a, []), do: false
  def is_sublist?(a, b) do
    cond do
      length(a) > length(b) -> false
      a === b -> true
      Enum.take(b, length(a)) === a -> true
      Enum.take(b, length(a) * -1) === a -> true
      true ->
        is_sublist?(a, tl(b))
    end
  end
end
