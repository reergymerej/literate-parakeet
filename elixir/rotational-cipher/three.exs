# Summary
# https://exercism.io/tracks/elixir/exercises/rotational-cipher/solutions/330aae8291ca4b2f8c61b39c98db2b9e
# * 'foo' is a charlist, a list of integers - [102, 111, 111]
# * "foo" is a string/UTF-8 encoded binary -  <<102, 111, 111>>
# * In iex, charlist and binaries will be printed as text if all their values
# are printable.

defmodule RotationalCipher do
  # module properties for each of the ranges we'll be checking
  @upper ?A..?Z
  @lower ?a..?z

  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  # typespec for rotate, takes a binary, int, returns a binary
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    # kernel provided, converts string to list of chars (ie ints)
    # This is weird in iex because it prints the string.  Using i, you can see
    # why.
    #
    # iex(79)> i(to_charlist("foo"))
    # Term
    #   'foo'
    # Data type
    #   List
    # Description
    #   This is a list of integers that is printed as a sequence of characters
    #   delimited by single quotes because all the integers in it represent valid
    #   ASCII characters. Conventionally, such lists of integers are referred to
    #   as "charlists" (more precisely, a charlist is a list of Unicode codepoints,
    #   and ASCII is a subset of Unicode).
    # Raw representation
    #   [102, 111, 111]#
      |> to_charlist

    # Pipe to Enum.map, use capture operator for anonymous function shorthand.
    # Each term is passed to rotate_char with shift for transformation into new
    # list.
      |> Enum.map(
        &(rotate_char(&1, shift))
      )

      # Turns list back into a string.
      |> to_string
  end

  defp rotate_char(char, shift) do
    # conditional, like switch but allows various expressions per clause
    # This could also have been handled with guards in the functionst pus.
    cond do
      # checks if which range we're in, upper or lower case
      # mods 26 with offset
      char in @upper -> rem(char - ?A + shift, 26) + ?A
      char in @lower -> rem(char - ?a + shift, 26) + ?a
      # default for everything outside our letter ranges, return unchanged
      true           -> char
    end
  end
end
