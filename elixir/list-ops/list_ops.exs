defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    
  end

  @spec reverse(list) :: list
  def reverse(l) do
    reduce(l, [], &([&1 | &2]))
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do

  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do

  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce(l, acc, f) do
    case l do
      [] ->
        acc
      [item] ->
        f.(item, acc)
      [item | less] ->
        f.(item, reduce(less, acc, f))
    end
  end

  @spec append(list, list) :: list
  def append(a, b) do
    reduce(a, b, &([&1 | &2]))
    |> reverse
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    reduce(ll, [], &(append(&1, &2)))
  end
end
