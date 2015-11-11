defmodule Roman do
  @int_to_roman %{
    1 => "I", 4 => "IV", 5 => "V", 9 => "IX",
    10 => "X", 40 => "XL", 50 => "L", 90 => "XC",
    100 => "C", 400 => "CD", 500 => "D", 900 => "CM",
    1000 => "M"
  }

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    numerals(number, "")
  end
  def numerals(number, romanized) do
    cond do
      number >= 1000 -> numerals(number - 1000, romanized <> @int_to_roman[1000])
      number >= 900 -> numerals(number - 900, romanized <> @int_to_roman[900])
      number >= 500 -> numerals(number - 500, romanized <> @int_to_roman[500])
      number >= 400 -> numerals(number - 400, romanized <> @int_to_roman[400])
      number >= 100 -> numerals(number - 100, romanized <> @int_to_roman[100])
      number >= 90 -> numerals(number - 90, romanized <> @int_to_roman[90])
      number >= 50 -> numerals(number - 50, romanized <> @int_to_roman[50])
      number >= 40 -> numerals(number - 40, romanized <> @int_to_roman[40])
      number >= 10 -> numerals(number - 10, romanized <> @int_to_roman[10])
      number >= 9 -> numerals(number - 9, romanized <> @int_to_roman[9])
      number >= 5 -> numerals(number - 5, romanized <> @int_to_roman[5])
      number >= 4 -> numerals(number - 4, romanized <> @int_to_roman[4])
      number >= 1 -> numerals(number - 1, romanized <> @int_to_roman[1])
      number = 0 -> romanized
    end
  end

  """
  def numerals(0, romanized), do: romanized
  def numerals(number, romanized) do
    [1000, 900, 500, 400,
      100, 90, 50, 40,
      10, 9, 5 , 4, 1]
    |> Enum.reduce_while("", fn(item, acc) ->
      cond do
        number >= item -> {:halt, numerals(number - item, romanized <> @int_to_roman[item])}
        true -> {:cont, acc}
      end
    end)
  end
  """
end
