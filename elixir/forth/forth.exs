defmodule Forth do
  @opaque evaluator :: any

  defstruct inputs: [], stack: [], syntax: %{}

  defmodule Operator do
    def math("+", [a, b | s]), do: [b + a | s]
    def math("-", [a, b | s]), do: [b - a | s]
    def math("*", [a, b | s]), do: [b * a | s]
    def math("/", [0, _ | _]), do: raise Forth.DivisionByZero
    def math("/", [a, b | s]), do: [div(b, a) | s]

    def dup(stack = [h | _]), do: [h | stack]
    def dup([]), do: raise Forth.StackUnderflow

    def drop([_ | stack]), do: stack
    def drop([]), do: raise Forth.StackUnderflow

    def over(stack = [_, b | _]), do: [b | stack]
    def over([_]), do: raise Forth.StackUnderflow
    def over([]), do: raise Forth.StackUnderflow

    def swap([a, b | stack]), do: [b, a | stack]
    def swap([_]), do: raise Forth.StackUnderflow
    def swap([]), do: raise Forth.StackUnderflow

    @spec parse(Forth.evaluator) :: Forth.evaluator
    def parse(ev = %Forth{inputs: []}), do: ev

    def parse(ev = %Forth{inputs: [":" | _]}) do
      Forth.eval(ev)
    end

    def parse(ev = %Forth{inputs: [h | inputs]}) when is_integer(h) do
      %Forth{ev | stack: [h | ev.stack], inputs: inputs}
      |> parse
    end
    def parse(ev = %Forth{stack: stack , inputs: [h | inputs]}) do
      case h do
        "DUP" -> %Forth{ev | stack: dup(stack), inputs: inputs}
        "DROP" -> %Forth{ev | stack: drop(stack), inputs: inputs}
        "OVER" -> %Forth{ev | stack: over(stack), inputs: inputs}
        "SWAP" -> %Forth{ev | stack: swap(stack), inputs: inputs}
        "+" -> %Forth{ev | stack: math(h, stack), inputs: inputs}
        "-" -> %Forth{ev | stack: math(h, stack), inputs: inputs}
        "*" -> %Forth{ev | stack: math(h, stack), inputs: inputs}
        "/" -> %Forth{ev | stack: math(h, stack), inputs: inputs}
        _ -> raise Forth.UnknownWord
      end
      |> parse
    end

  end

  @doc """
  Create a new evaluator.
  """
  @spec new() :: evaluator
  def new() do
    %Forth{}
  end

  @doc """
  Evaluate an input string, then update the evaluator state.
  """
  @spec eval(evaluator, String.t) :: evaluator
  def eval(ev, s) do
    inputs = s
    |> clean

    case inputs do
      ": " <> _ ->
        [definition, tail] = inputs
        |> String.split(";", parts: 2)

        redefine(ev, definition)
        |> eval(tail)
       _ ->
        list = inputs
        |> expand(ev)
        |> tokenize

        %Forth{ev | inputs: ev.inputs ++ list}
        |> eval
    end
  end

  @doc """
  If there's no new input to add, start operation
  """
  @spec eval(evaluator) :: evaluator
  def eval(ev) do
    ev
    |> Operator.parse
  end

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  @spec format_stack(evaluator) :: String.t
  def format_stack(%Forth{stack: stack}) do
    stack
    |> Enum.reverse
    |> Enum.join(" ")
  end

  @spec clean(String.t) :: String.t
  def clean(s) do
    s
    |> String.replace(~r/[^\p{L}\p{N}\p{S}\p{P}]+/u, " ")
    |> String.upcase
  end

  @spec redefine(evaluator, String.t) :: Tuple.t
  def redefine(ev, ": " <> inputs) do
    [key, words] = inputs
    |> String.split(" ", parts: 2)

    case Integer.parse(key) do
      {i, _} -> raise Forth.InvalidWord, word: i
      _ -> %Forth{ev | syntax: Map.put(ev.syntax, key, words)}
    end
  end

  @spec expand(String.t, evaluator) :: String.t
  def expand(s, %Forth{syntax: syntax}) do
    syntax
    |> Enum.reduce(s, fn({key, words}, acc) ->
      acc
      |> String.replace(key, words)
    end)
  end

  @spec tokenize(String.t) :: List.t
  def tokenize(s) do
    s
    |> String.split(" ", trim: true)
    |> Enum.map(fn(item) ->
      case Integer.parse(item) do
        {i, _} -> i
        _ -> item
      end
    end)
  end

  defmodule StackUnderflow do
    defexception [:message]
    def exception(_), do: %StackUnderflow{message: "stack underflow"}
  end

  defmodule InvalidWord do
    defexception [:message, :word]
    def exception(e), do: %InvalidWord{message: "invalid word: #{inspect e}", word: e}
  end

  defmodule UnknownWord do
    defexception [:message, :word]
    def exception(e), do: %UnknownWord{message: "unknown word: #{inspect e}", word: e}
  end

  defmodule DivisionByZero do
    defexception [:message]
    def exception(_), do: %DivisionByZero{message: "division by zero"}
  end
end
