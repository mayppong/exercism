defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(Dict.t) :: map()
  def transform(input) do
    Enum.reduce(input, %{}, fn({value, list}, acc) ->
      Enum.reduce(list, acc, fn(char, acc) ->
        Dict.put(acc, String.downcase(char), value)
      end)
    end)
  end
end
