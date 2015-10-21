defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) when is_list(strand), do: count(List.to_string(strand), nucleotide)
  def count(strand, nucleotide) do
    String.replace(strand, ~r/[^#{<<nucleotide ::utf8>>}]/i, "")
    |> String.length
  end


  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.nucleotide_counts('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec nucleotide_counts([char]) :: Dict.t
  def nucleotide_counts(strand) do
    @nucleotides
    |> Enum.reduce(%{}, fn(item, acc) ->
      Dict.put(acc, item, count(strand, item))
    end)
  end
end
