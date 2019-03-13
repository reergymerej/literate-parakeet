defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) do
    count(0, l)
  end

  defp count(acc, []) do
    acc
  end

  defp count(acc, [head | tail]) do
    count(acc + 1, tail)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    reverse([], l)
  end

  defp reverse(acc, []) do
    acc
  end

  defp reverse(acc, [head | tail]) do
    reverse([head | acc], tail)
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    map([], l, f)
  end

  defp map(acc, [], f) do
    reverse([], acc)
  end

  defp map(acc, [head | tail], f) do
    map(([f.(head) | acc]), tail, f)
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    filter([], l, f)
  end

  defp filter(acc, [], f) do
    reverse([], acc)
  end

  defp filter(acc, [head | tail], f) do
    if f.(head) do
      filter([head | acc], tail, f)
    else
      filter(acc, tail, f)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([head | tail], acc, f) do
    reduce(tail, f.(head, acc), f)
  end

  def reduce([], acc, f) do
    acc
  end

  @spec append(list, list) :: list
  def append([], b) do
    b
  end

  def append(a, []) do
    a
  end

  def append(a, b) do
    inner_append(reverse(a), b)
  end

  defp inner_append(acc, []) do
    reverse(acc)
  end

  defp inner_append(acc, [head | tail]) do
    inner_append([head | acc], tail)
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    reduce(ll, [], &(append(&2, &1)))
  end
end
