defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    # @spec digits(integer(), pos_integer()) :: [integer(), ...]
    # Returns the ordered digits for the given integer.
    # returns a list of binary digits of "code"
    Integer.digits(code, 2)

    # reverses, can optionally append another list
    # This is reversed so we can work through the digit from 1 to 16.
    |> Enum.reverse

    # replaces each item in list with a tuple, { item, index }
    |> Enum.with_index

    # We know reduce as Enum.reduce(enumerable, initial, fn).
    # Is this the capture operator agoin?
    # Yes.  And this is hot.  This answers a question I had earlier about
    # passing functions around.
    # You can refer to a local function, like
    # x = &some_local_fn
    # x.()
    #
    # Or, you can use it to refer to a function and its arity, which is what
    # this next line does.
    # &(module_name.function_name/arity)
    #
    # This refers to the append definitions below, so it's local, which is why
    # there's no module definition.
    |> Enum.reduce([], &append/2)

    |> Enum.reverse
  end

  # Each of these is passed two args, the tuple from with_index, and the
  # accumulator.  As we've seen elsewhere, instead of putting logic where append
  # is being called, we add the logic by defining different versions of it here.
  #
  # What is defp?
  # defp DEFines a Private function.

  # Pattern matching is used for each scenario.
  # This bit is off, just return the accumulator.
  defp append({0, _}, acc), do: acc

  # We don't check to see if the values are on or off, just the index.  How does
  # this not get hit if the bit is off?
  #
  # :| Nevermind.  If it's off, it is caught before it gets here.
  # For whatever the index, it prepends the value.
  defp append({_, 0}, acc), do: ["wink" | acc]
  defp append({_, 1}, acc), do: ["double blink" | acc]
  defp append({_, 2}, acc), do: ["close your eyes" | acc]
  defp append({_, 3}, acc), do: ["jump" | acc]

  # reverse it
  # The values were in order, so this will be the last one always, excluding the
  # default (if accidentally used).  This means we don't have to worry about the
  # prepending above here ever happening _after_ this.

  # All the above PREPEND instead of appending so that we get a final chance to
  # reverse again.  We can't reverse at the beginning, before we've added
  # anything.
  defp append({_, 4}, acc), do: Enum.reverse(acc)

  # default, return accumulator
  defp append({_, _}, acc), do: acc

end
