defmodule Minesweeper do

  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t]) :: [String.t]
  def annotate([]), do: []
  def annotate(board) do
    height = board |> Enum.count
    width = board |> hd |> String.length
    Stream.with_index(board)
    |> Enum.map(fn({row, y}) ->
      row
      |> String.to_char_list
      |> Stream.with_index
      |> Enum.map(fn({elem, x}) ->
        case elem do
          ?* -> ?*
          ?\s ->
            count = crawl(board, {x, y}, {width, height})
            case count do
              0 -> ?\s
              _ -> count |> to_char_list
            end
        end
      end)
      |> List.to_string
    end)

  end

  @doc """
  If position we're currently on is detected as " ", we should count the
  surrounding "*" and update the number
  """
  def crawl(board, {x, y}, {width, height}) do
    {x ,y}
    |> adjacent({width, height})
    |> Enum.reduce(0, fn({i, j}, acc) ->
      elem = board
      |> Enum.fetch!(j)
      |> String.at(i)

      case elem do
        "*" -> acc + 1
        _ -> acc
      end
    end)
  end

  @doc """
  Returns a list of valid adjacent positions.
  """
  def adjacent({x, y}, {width, height}) do
    for i <- x-1..x+1,
      j <- y-1..y+1,
      !(i == x and j == y) and is_valid?({i, j}, {width, height}) do
        {i, j}
    end
  end

  def is_valid?({i, j}, {width, height}) do
      i >= 0 and i < width and j >= 0 and j < height
  end

end
