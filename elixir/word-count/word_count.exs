defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map()
  def count(sentence) do
    String.replace(sentence, ~r/[.,\/#!$%\^&\*;:{}=`~()@]/, "")
      |> String.downcase
      |> String.split([" ", "_"], trim: true)
      |> Enum.reduce(Map.new, fn(word, dict) ->
        Map.update(dict, word, 1, &(&1 + 1))
      end)
  end
end
