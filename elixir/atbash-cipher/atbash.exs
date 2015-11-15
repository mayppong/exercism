defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t) :: String.t
  def encode(plaintext) do
    String.replace(plaintext, ~r/[^\w]/, "")
    |> String.downcase
    |> String.to_char_list
    |> Enum.map(fn(char) ->
      cond do
        char >= ?a and char <= ?z ->
          << ?a + (?z - char) >>
        true ->
          << char >>
      end
    end)
    |> Enum.chunk(5, 5, [])
    |> Enum.intersperse(" ")
    |> Enum.join
  end
end
