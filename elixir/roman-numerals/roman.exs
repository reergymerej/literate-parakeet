defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    number
    |> Integer.digits()
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(&do_digit/1)
    |> Enum.reverse()
    |> Enum.join()
  end

  defp do_digit(number) do
    case number do
      {0, _} -> ""

      {1, 0} -> "I"
      {2, 0} -> "II"
      {3, 0} -> "III"
      {4, 0} -> "IV"
      {5, 0} -> "V"
      {6, 0} -> "VI"
      {7, 0} -> "VII"
      {8, 0} -> "VIII"
      {9, 0} -> "IX"

      {1, 1} -> "X"
      {2, 1} -> "XX"
      {3, 1} -> "XX"
      {4, 1} -> "XL"
      {5, 1} -> "L"
      {6, 1} -> "LX"
      {7, 1} -> "LXX"
      {8, 1} -> "LXXX"
      {9, 1} -> "XC"

      {1, 2} -> "C"
      {2, 2} -> "CC"
      {3, 2} -> "CCC"
      {4, 2} -> "CD"
      {5, 2} -> "D"
      {6, 2} -> "DC"
      {7, 2} -> "DCC"
      {8, 2} -> "DCCC"
      {9, 2} -> "CM"

      {1, 3} -> "M"
      {2, 3} -> "MM"
      {3, 3} -> "MMM"
    end
  end
end
