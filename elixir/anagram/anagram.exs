defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    down_base = String.downcase(base)
    norm_base = normalize(base)
    Enum.reduce(candidates, [], fn(item, acc) ->
      cond do
        normalize(item) === norm_base and String.downcase(item) !== down_base ->
          [item | acc]
        true ->
          acc
      end
    end)
    |> Enum.reverse
  end

  def normalize(word) do
    word
    |> String.downcase
    |> String.to_char_list
    |> Enum.sort
  end
end
