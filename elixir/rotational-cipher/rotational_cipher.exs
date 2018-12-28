defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist()
    |> Enum.map(fn(char) -> shift_char(char, shift) end)
    |> to_string()
  end

  defp shift_char(char, _) when (char < ?A) do char end
  defp shift_char(char, _) when (char > ?z) do char end
  defp shift_char(char, _) when (char > ?Z and char < ?a) do char end
  defp shift_char(char, shift) when (char <= ?Z and char + shift > ?Z) do
    ?A + (char + shift) - ?Z - 1
  end
  defp shift_char(char, shift) when (char <= ?z and char + shift > ?z) do
    ?a + (char + shift) - ?z - 1
  end
  defp shift_char(char, shift) do char + shift end
end
