defmodule DNA do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> DNA.hamming_distance('AAGTCATA', 'TAGCGATC')
  4
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) when length(strand1) !== length(strand2), do: nil
  def hamming_distance(strand1, strand2) do
    Enum.zip(strand1, strand2)
    |> Enum.reduce(0, fn(item, acc) ->
      {head1, head2} = item
      cond do
        head1 !== head2 -> acc + 1
        true -> acc
      end
    end)
  end
end
