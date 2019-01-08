defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ", trim: true)
    |> Enum.map(&(do_translate_word(&1)))
    |> Enum.join("")
  end

  defp do_translate_word(word) do
    cond do
      not (starts_with_consonant?(word)) ->
        word <> "ay"
      true ->
        count = get_leading_consonants_count(word, 0)
        <<head::binary-size(count), tail::binary>> = word
        tail <> head <> "ay"
    end
  end

  defp starts_with_consonant?(word) do
    not (String.starts_with?(word, ~w(a e i o u)))
  end

  defp get_leading_consonants_count(word, acc) do
    if (starts_with_consonant?(word)) do
      <<_head::binary-size(1), tail::binary>> = word
      get_leading_consonants_count(tail, acc + 1)
    else
      acc
    end
  end
end
