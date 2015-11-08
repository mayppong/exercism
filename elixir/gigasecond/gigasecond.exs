defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({pos_integer, pos_integer, pos_integer}) :: :calendar.date

  def from({year, month, day}) do
    {date, time} = :calendar.date_to_gregorian_days(year, month, day)
    |> day_to_second
    |> add_billion_seconds
    |> :calendar.gregorian_seconds_to_datetime

    date
  end

  def day_to_second(day) do
    day * 86400
  end

  def add_billion_seconds(second) do
    second + 1_000_000_000
  end
end
