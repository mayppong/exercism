defmodule Allergies do

  @allergies %{
    128 => "cats",
    64 => "pollen",
    32 => "chocolate",
    16 => "tomatoes",
    8 => "strawberries",
    4 => "shellfish",
    2 => "peanuts",
    1 => "eggs"
  }

  @scores [128, 64, 32, 16, 8, 4, 2, 1]

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(flags) do
    components = flags
    |> breakdown
    case components do
      [] -> components
      _  -> Enum.uniq(components)
        |> Enum.map(fn(item) ->
          @allergies[item]
        end)
    end
  end

  @doc """
  Break the flags value down to smaller score components
  Duplicate scores are allowed.

  # Example
    iex> breakdown(256)
    [128, 128]
  """
  def breakdown(0), do: []
  def breakdown(flags) do
    next = Enum.find(@scores, fn(score) ->
      flags - score >= 0
    end)
    [next | breakdown(flags - next)]
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item) do
    list(flags)
    |> Enum.member?(item)
  end
end
