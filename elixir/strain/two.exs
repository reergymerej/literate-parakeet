defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  # What is for x <-?
  # It's a comprehension.
  # https://elixir-lang.org/getting-started/comprehensions.html
  # The comprehensions are fun, but this is sort of a cheat.
  def keep(list, fun), do: for x <- list, fun.(x), do: x

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun), do: for x <- list, !fun.(x), do: x
end

# This is a nifty trick to pin formatting in the file.
# https://news.ycombinator.com/item?id=2442974
# vim:et sts=2 sw=2
