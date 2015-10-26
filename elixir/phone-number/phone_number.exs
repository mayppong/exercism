defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    validate(raw)
    |> String.replace(~r/[^\d]/, "")
    |> strip_country_code
  end
  def validate(raw) do
    cond do
      String.upcase(raw) !== String.downcase(raw)
        -> "0000000000"
      true -> raw
    end
  end
  def strip_country_code(digits) do
    cond do
      String.length(digits) === 10
        -> digits
      String.length(digits) === 11 and String.starts_with?(digits, "1")
        -> String.slice(digits, 1, 10)
      true
        -> "0000000000"
    end
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    number(raw)
    |> String.slice(0, 3)
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    digits = number(raw)
    "(#{String.slice(digits, 0, 3)}) #{String.slice(digits, 3, 3)}-#{String.slice(digits,6,4)}"
  end
end
