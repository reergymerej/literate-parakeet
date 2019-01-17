defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) when (number == 0) do
    """
    #{get_line(number)}
    Go to the store and buy some more, 99 bottles of beer on the wall.
    """
  end

  def verse(number) do
    """
    #{get_line(number)}
    Take #{next_beer_pronoun(number - 1)} down and pass it around, #{beer_address(number - 1)} of beer on the wall.
    """
  end

  defp get_line(beer_number) do
    "#{beer_address(beer_number)} of beer on the wall, #{beer_address(beer_number)} of beer."
    |> String.capitalize()
  end

  defp next_beer_pronoun(number) when (number > 0) do
    "one"
  end

  defp next_beer_pronoun(number) when (number == 0) do
    "it"
  end

  defp beer_address(number) when (number > 1) do
    "#{number} bottles"
  end

  defp beer_address(number) when (number == 1) do
    "#{number} bottle"
  end

  defp beer_address(number) when (number == 0) do
    "no more bottles"
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do
    Enum.reduce(range, [], fn (number, acc) -> acc ++ [verse(number)] end)
    |> Enum.join("\n")
  end
end
