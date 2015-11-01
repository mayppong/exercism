defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @doc """
  Using the same convention as erlang's day_of_the_week
  http://www.erlang.org/doc/man/calendar.html#day_of_the_week-3
  """
  @daynum [monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6, sunday: 7]

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.

  This function uses Erlang's calendar library to figure the last day of the
  month (28..31). The function used is `last_day_of_the_week/2`
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    day = :calendar.last_day_of_the_month(year, month)
    |> schedule_to_range(schedule)
    |> Enum.find(fn(day) ->
      :calendar.day_of_the_week(year, month, day) === @daynum[weekday]
    end)

    {year, month, day}
    
  end

  @doc """
    Given last day of the month and the quater of the month, return the range
    of day.
  """
  def schedule_to_range(last_day, schedule) do
    case schedule do
      :first -> 1..7
      :second -> 8..14
      :third -> 15..21
      :fourth -> 22..28
      :last -> (last_day - 6)..last_day
      :teenth -> 13..19
    end
  end

end
