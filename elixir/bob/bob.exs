defmodule Bob do
  def hey(input) do
    cond do
      silence?(input) -> "Fine. Be that way!"

      question?(input) and shouting?(input) -> "Calm down, I know what I'm doing!"

      question?(input) -> "Sure."

      shouting?(input) -> "Whoa, chill out!"

      true -> "Whatever."
    end
  end

  defp silence?(text) do
    String.trim(text) == ""
  end

  defp shouting?(text) do
    String.upcase(text) == text and !caps?(text)
  end

  defp caps?(text) do
    text
    |> String.split()
    |> Enum.all?(&(String.capitalize(&1) == &1))
  end

  defp question?(text) do
    String.ends_with?(text, "?")
  end
end
