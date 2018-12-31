# https://exercism.io/tracks/elixir/exercises/strain/solutions/c8fd4248ae3a2d4ce6dd966d
#
defmodule Strain do

  @doc """
  Keep all entries in a collection that return true for a given function.

  Using filter would work, but don't use it.
  """
  @spec keep(Enum.t, (any -> as_boolean(term))) :: list
  def keep(collection, function) do
    filter(collection, function)
  end

  @doc """
  Discard all entries in a collection that return true for a given function.

  Using reject would work, but don't use it.
  """
  @spec discard(Enum.t, (any -> as_boolean(term))) :: list
  def discard(collection, function) do
    # An anonymous function is made using the capture operator to negate the
    # check.
    filter(collection, &(not function.(&1)))
  end

  defp filter(collection, function) do
    Enum.reduce(collection, [], fn (element, acc) ->

      # if and unless are macros
      # https://elixir-lang.org/getting-started/case-cond-and-if.html#if-and-unless
      # defmacro if(condition, clauses)
      # if(foo, do: bar, else: baz)
      #
      # It looks like this reverses the list.
      if(function.(element), do: [element | acc], else: acc)
    end) |> Enum.reverse
  end
end
