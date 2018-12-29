defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """

  @lower ?a..?z
  @upper ?A..?Z

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist()
    |> Enum.map(&(shift_char(&1, shift)))
    |> to_string()
  end

  defp shift_char(char, shift) when (char in @upper) do
    rem(char - ?A + shift, 26) + ?A
  end
  defp shift_char(char, shift) when (char in @lower) do
    rem(char - ?a + shift, 26) + ?a
  end
  defp shift_char(char, _), do: char
end
