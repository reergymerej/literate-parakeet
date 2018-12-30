defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    do_filter(list, fun, true)
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    # This is the same as keep, but with a reversed predicate.
    do_filter(list, fun, false)
  end

  defp do_filter(list, fun, predicate_result) do
    # We need to build a new list.
    # We can still iterate the list, just not use filter.
    # We can't be side-effecty and test within the loop, adding to an external
    # list.  Instead, we need to pass the accumulator.
    Enum.reduce(list, [], fn(term, acc) ->
      if (fun.(term) == predicate_result) do
        acc ++ [term]
      else
        acc
      end
    end)
  end
end
