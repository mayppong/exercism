defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    String.replace(string, ~r/[^01]/, "")
    |> String.reverse
    |> String.split("", trim: true)
    |> Enum.with_index
    |> Enum.reduce(0, fn({item, position}, acc) ->
      case item do
        "0" -> acc
        "1" -> acc + :math.pow(2, position)
      end
    end)
  end
end
