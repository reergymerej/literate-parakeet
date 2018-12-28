defmodule SecretHandshake do
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

  # easy to extend
  @rules [
    { 0b1, "wink" },
    { 0b10, "double blink" },
    { 0b100, "close your eyes" },
    { 0b1000, "jump" },
    { 0b10000, &Enum.reverse/1 },
  ]

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    Enum.reduce(@rules, [], fn(x, acc) ->
      { num, result } = x
      do_commands(acc, num == (code &&& num), result)
    end)
  end

  defp do_commands(acc, do?, todo)
  defp do_commands(acc, false, _), do: acc
  defp do_commands(acc, true, str) when is_binary(str), do: acc ++ [str]
  defp do_commands(acc, true, fun), do: fun.(acc)
end
