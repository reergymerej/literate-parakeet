defmodule Bob do
  def hey(input) do
    cond do
      is_silence?(input) -> "Fine. Be that way!"

      is_question?(input) and is_shouting?(input) -> "Calm down, I know what I'm doing!"

      is_question?(input) -> "Sure."

      is_shouting?(input) -> "Whoa, chill out!"

      true -> "Whatever."
    end
  end

  defp is_silence?(text) do
    String.trim(text) == ""
  end

  defp is_shouting?(text) do
    String.upcase(text) == text and !is_using_caps?(text)
  end

  defp is_using_caps?(text) do
    text
    |> String.split()
    |> Enum.all?(&(String.capitalize(&1) == &1))
  end

  defp is_question?(text) do
    String.ends_with?(text, "?")
  end
end
