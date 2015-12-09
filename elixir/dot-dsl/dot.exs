defmodule Graph do
  defstruct attrs: [], nodes: [], edges: []

  def update(struct, :attrs, [{key, option}]) do
    attrs = [{key, option}] ++ struct.attrs |> Enum.sort
    %Graph{struct | attrs: attrs}
  end

  def update(struct, :nodes, [{point, option}]) do
    nodes = [{point, option}] ++ struct.nodes |> Enum.sort
    %Graph{struct | nodes: nodes}
  end

  def update(struct, :edges, [from, to, option]) do
    edges = [{from, to, option}] ++ struct.edges
    %Graph{struct | edges: edges}
  end

  def update(_, type, option), do: raise ArgumentError
end

defmodule Dot do
  defmacro graph([do: ast]) do
    Dot.parse(%Graph{}, ast)
    |> Macro.escape(unquote: true)
  end

  def parse(graph, nil), do: graph

  def parse(graph, {:__block__, _, options}) do
    Enum.reduce(options, graph, fn(option, acc) ->
      Dot.parse(acc, option)
    end)
  end

  def parse(graph, {:graph, _, options}) do
    case options do
      nil ->  graph
      [] ->   graph
      [[]] -> graph
      [option] ->
        Graph.update(graph, :attrs, option)
    end
  end

  def parse(graph, {:--, _, options}) do
    case options do
      [{from, _, _}, {to, _, nil}] ->
        Graph.update(graph, :edges, [from, to, []])
      [{from, _, _}, {to, _, [option]}] ->
        Graph.update(graph, :edges, [from, to, option])
      _ ->
        raise ArgumentError
    end
  end

  def parse(graph, {point, _, options}) do
    validate_point(point)

    case options do
      nil ->  Graph.update(graph, :nodes, [{point, []}])
      [] ->   Graph.update(graph, :nodes, [{point, []}])
      [[]] -> Graph.update(graph, :nodes, [{point, []}])
      [[{key, value}]] ->
        Graph.update(graph, :nodes, [{point, [{key, value}]}])
      _ ->
        raise ArgumentError
    end
  end

  def parse(_, _), do: raise ArgumentError

  def validate_point(point) do
    if not is_atom(point), do: raise ArgumentError
  end
end
