defmodule TwelveDays do
  @days [
    "first",
    "second",
    "third",
    "fourth",
    "fifth",
    "sixth",
    "seventh",
    "eighth",
    "ninth",
    "tenth",
    "eleventh",
    "twelfth",
  ]

  @gifts [
      "a Partridge in a Pear Tree.",
      "two Turtle Doves",
      "three French Hens",
      "four Calling Birds",
      "five Gold Rings",
      "six Geese-a-Laying",
      "seven Swans-a-Swimming",
      "eight Maids-a-Milking",
      "nine Ladies Dancing",
      "ten Lords-a-Leaping",
      "eleven Pipers Piping",
      "twelve Drummers Drumming",
  ]

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    prelude = "On the #{(Enum.at(@days, number - 1))} day of Christmas my true love gave to me:"
    items = Enum.slice(@gifts, 0, number)
            |> Enum.reverse()

    items = if number > 1 do
      List.replace_at(items, -1, "and " <> Enum.at(items, -1))
    else
      items
    end

    items = Enum.join(items, ", ")

    "#{prelude} #{items}"
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    Enum.map_join(starting_verse..ending_verse,
      "\n",
      fn verse -> TwelveDays.verse(verse) end)
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    TwelveDays.verses(1, 12)
  end
end
