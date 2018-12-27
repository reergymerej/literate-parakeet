use Bitwise

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
    # convert code to binary
    # use Bitwise (or div/rem)
    # 16 &&& 10000 = 16
    #
    # These are just bitflags.  To check them, just use AND for the one we're
    # interested in.
    #
    # Should we wink?
    # code &&& 1 === 1
    #
    # It would be nice to write these in binary.  How?
    #
    # 0b1010101
    # rtl, check bits and add to list of commands
    # reverse if 10000
    checks = [
      { 0b1, "wink" },
      { 0b10, "double blink" },
      { 0b100, "close your eyes"},
      { 0b1000, "jump"}
    ]
    actions = Enum.reduce(checks, [], fn(tup, acc) ->
      { flag, val } = tup
      if ((flag &&& code) === flag) do
        # How do we appned to a list?
        acc ++ [val]
      else
        acc
      end
    end)

    if ((0b10000 &&& code) === 0b10000) do
      Enum.reverse(actions)
    else
      actions
    end
  end
end
