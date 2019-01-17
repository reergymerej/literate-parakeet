defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) when (number == 0) do
    """
    No more bottles of beer on the wall, no more bottles of beer.
    Go to the store and buy some more, 99 bottles of beer on the wall.
    """
  end

  def verse(number) do
    """
    #{beer_address(number)} of beer on the wall, #{beer_address(number)} of beer.
    Take #{next_beer_pronoun(number - 1)} down and pass it around, #{beer_address(number - 1)} of beer on the wall.
    """
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
  def lyrics(range) do
    Enum.reduce(range, "", fn (number, acc) -> acc <> verse(number) end)
  end
end
