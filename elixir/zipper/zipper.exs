defmodule BinTree do
  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """
  @type t :: %BinTree{ value: any, left: BinTree.t | nil, right: BinTree.t | nil }
  defstruct value: nil, left: nil, right: nil
end

defmodule Zipper do
  defstruct focus: nil, tree: nil, branches: []

  @doc """
  Get a zipper focused on the tree node.
  """
  @spec from_tree(BT.t) :: Z.t
  def from_tree(bt) do
    %Zipper{focus: bt, tree: bt}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Z.t) :: BT.t
  def to_tree(z) do
    z.tree
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Z.t) :: any
  def value(z) do
    z.focus.value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Z.t) :: Z.t | nil
  def left(%Zipper{focus: %BinTree{left: nil}}), do: nil
  def left(z) do
    %Zipper{z | focus: z.focus.left, branches: [:left | z.branches]}
  end
  
  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Z.t) :: Z.t | nil
  def right(%Zipper{focus: %BinTree{right: nil}}), do: nil
  def right(z) do
    %Zipper{z | focus: z.focus.right, branches: [:right | z.branches]}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Z.t) :: Z.t
  def up(z) do
    #TODO
    z
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Z.t, any) :: Z.t
  def set_value(z = %Zipper{focus: focus}, v) do
    new_focus = %BinTree{focus | value: v}
    set_focus(z, new_focus)
  end
  
  @doc """
  Replace the left child tree of the focus node. 
  """
  @spec set_left(Z.t, BT.t) :: Z.t
  def set_left(z = %Zipper{focus: focus}, l) do
    new_focus = %BinTree{focus | left: l}
    set_focus(z, new_focus)
  end
  
  @doc """
  Replace the right child tree of the focus node. 
  """
  @spec set_right(Z.t, BT.t) :: Z.t
  def set_right(z = %Zipper{focus: focus}, r) do
    new_focus = %BinTree{focus | right: r}
    set_focus(z, new_focus)
  end

  def set_focus(z, new) do
    %Zipper{z | focus: new, tree: rebuild(z.tree, Enum.reverse(z.branches), new)}
  end

  def rebuild(tree, [direction | branches], replacement) do
    case direction do
      :right ->
        %BinTree{tree | right: tree |> from_tree |> right |> rebuild(branches, replacement)}
      :left ->
        %BinTree{tree | left: tree |> from_tree |> left |> rebuild(branches, replacement)}
    end
  end
  def rebuild(tree, [], replacement), do: replacement
end
