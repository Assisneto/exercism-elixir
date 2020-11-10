defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) do
    acc = 0
    count(l, acc)
  end

  def count([_ | tail], acc), do: count(tail, acc + 1)

  def count([], acc), do: acc

  # ---------------------------------------------
  # ---------------------------------------------

  @spec reverse(list) :: list
  def reverse(l) do
    acc = []
    reverse(l, acc)
  end

  def reverse([head | tail], acc), do: reverse(tail, [head | acc])

  def reverse([], acc), do: acc
  # ---------------------------------------------
  # ---------------------------------------------

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    acc = []
    map(l, f, acc)
  end

  def map([head | tail], f, acc), do: map(tail, f, [f.(head) | acc])

  def map([], _, acc), do: reverse(acc)

  # ---------------------------------------------
  # ---------------------------------------------

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    acc = []
    filter(l, f, acc)
  end

  def filter([head | tail], f, acc), do: filter(tail, f, acc, head, f.(head))

  def filter([], _f, acc), do: reverse(acc)

  def filter(l, f, acc, head, true), do: filter(l, f, [head | acc])

  def filter(l, f, acc, _head, false), do: filter(l, f, acc)


  # ---------------------------------------------
  # ---------------------------------------------

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([head | tail], acc, f), do: reduce(tail, f.(head, acc), f)

  def reduce([], acc, _f), do: acc

  # ---------------------------------------------
  # ---------------------------------------------

  @spec append(list, list) :: list

  def append(a, b) do
    reverse(a)
    |> reduce(b, &[&1 | &2])
  end

  # ---------------------------------------------
  # ---------------------------------------------

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    reduce(ll, [], fn x, acc -> append(acc, x) end)
  end

end
