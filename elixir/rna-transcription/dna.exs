defmodule DNA do

  @transcription %{
    ?G: ?C,
    ?C: ?G,
    ?T: ?A,
    ?A: ?U
  }

  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> DNA.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna
    |> Enum.map(fn(item) ->
      case item do
        ?G -> ?C
        ?C -> ?G
        ?T -> ?A
        ?A -> ?U
        _ -> nil
      end
    end)

  end
end
