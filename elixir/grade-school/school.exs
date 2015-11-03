defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(Dict.t, String.t, pos_integer) :: Dict.t
  def add(db, name, grade) do
    Dict.update(db, grade, [name], &([name | &1]))
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(Dict.t, pos_integer) :: [String]
  def grade(db, grade) do
    Dict.get(db, grade, [])
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(Dict) :: Dict.t
  def sort(db) do
    Enum.into(db, %{}, fn({num, students}) ->
      {num, Enum.sort(students)}
    end)
  end
end
