# Summary
# * binary, octal, and hex notations are supported (0b1, 0o1, 0x1)
# * a function head can be used to document a fn, even without default args

defmodule SecretHandshake do
  # https://elixir-lang.org/getting-started/alias-require-and-import.html#use
  # This pulls in the Bitwise module.  Usually import and alias are preferred.
  use Bitwise

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
    # Start with an empty list.
    []
    # pipe list into private function for each condition
    # https://elixir-lang.org/getting-started/basic-types.html#basic-arithmetic
    # 0b1000 - binary 8
    # 0o1000 - octal 512
    # 0x1000 - hex 4096
    |> do_commands(0x08 == (code &&& 0x08), "jump")
    |> do_commands(0x04 == (code &&& 0x04), "close your eyes")
    |> do_commands(0x02 == (code &&& 0x02), "double blink")
    |> do_commands(0x01 == (code &&& 0x01), "wink")

    # This uses the capture operator to refer to the Enum module's reverse/1.
    # There's also Enum.reverse/2, which appends another list after reversing.
    |> do_commands(0x10 == (code &&& 0x10), &Enum.reverse/1)
  end

  # What is this annotation with no implemenation?
  # If a function with default values has multiple clauses, it is required to
  # create a function head (without an actual body) for declaring defaults:
  #
  # The function head is for use with default values, but where's the default?
  # It doesn't seem there _are_ any defaults.  They use \\.
  # Maybe this is just for documentation.
  # https://blog.robphoenix.com/elixir/notes-on-elixir-bodyless-functions/
  # https://hexdocs.pm/elixir/writing-documentation.html#function-arguments
  #
  # Yep.  This is for clarity/documentation only.
  defp do_commands(acc, do?, todo)

  # If do? is false, whatever.
  defp do_commands(acc, false, _), do: acc

  # If true and binary, prepend the string to the accumulator.
  defp do_commands(acc, true, str) when is_binary(str), do: [str | acc]

  # The 3rd arg must be a function, so let's call it, passing the accumulator.
  defp do_commands(acc, true, fun), do: fun.(acc)
end
