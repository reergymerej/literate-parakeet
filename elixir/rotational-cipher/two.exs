defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  # typespec
  #   - text, UTF-8 encoded binary (string)
  #   - shift, integer
  #
  #     https://hexdocs.pm/elixir/typespecs.html#the-string-type
  #       string() - Erlang string, Elixir charlist
  #       charlist() - [char()], list of 0..0x10FFFF
  #       binary() - a sequence of bytes, a bitstring where the number of bits is
  #         divisible by 8.
  #       https://elixir-lang.org/getting-started/binaries-strings-and-char-lists.html#binaries-and-bitstrings
  #       String.t() - string type
  #
  #   - returns a string/binary
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    # Pipes text to `to_charlist`.
    # to_charlist converts "a term" to a charlist usint the List.Chars protocol.
    |> to_charlist
    |> rotate(shift, "")
  end

  # Empty list, who cares, out, return out.
  def rotate([], _, out) do out end

  # If the list has a head and tail...
  def rotate([head | tail], shift, out) do

    # Recurses, goofing around with head
    rotate(tail, shift, head
      # passes head, the first string to rot along with shift
    |> rot(shift)

      # converts a list of ints to a string (String.t())
    |> List.to_string

      # pipes list of String.t() and out to cat
    |> cat(out))
  end

  # This is cool.  It uses `in` to check of the value is in the range.
  # https://hexdocs.pm/elixir/Kernel.html#in/2
  # in/2 is a macro that converts to Enum.member?/2
  #
  # How do macros actually work?
  #
  # rem is i(rem/2)
  defp rot(a, shift) when a in ?a..?z, do: [rem(a + shift - ?a, 26) + ?a]
  defp rot(a, shift) when a in ?A..?Z, do: [rem(a + shift - ?A, 26) + ?A]

  defp rot(a, _), do: [a]

  # adds a to b, converts to String.t()
  defp cat(a, b) do Enum.join([b, a], "") end
end
