defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({pos_integer, pos_integer, pos_integer}) :: :calendar.date

  def from({year, month, day}) do
    {days_since, _} = :calendar.seconds_to_daystime(1_000_000_000)

    :calendar.date_to_gregorian_days(year, month, day)
    |> + days_since
    |> :calendar.gregorian_days_to_date
  end
end
