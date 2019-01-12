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
      starts_with_vowel_sound?(word) ->
        word <> "ay"

      starts_with_y_after_consonants?(word) ->
        count = get_leading_consonants_count(word)
        <<head::binary-size(count), tail::binary>> = word
        tail <> head <> "ay"

      starts_with_consonant_and_qu?(word) ->
        count = get_leading_consonants_count(word) + 2
        { head, tail } = String.split_at(word, count - 1)
        tail <> head <> "ay"

      starts_with_consonant?(word) ->
        count = get_leading_consonants_count(word)
        <<head::binary-size(count), tail::binary>> = word
        tail <> head <> "ay"
    end
  end

  defp starts_with_vowel_sound?(word) do
    not starts_with_consonant?(word)
    or String.starts_with?(word, ["xr", "yt"])
  end

  defp starts_with_consonant?(word) do
    not (String.starts_with?(word, ~w(a e i o u)))
  end

  defp starts_with_consonant_and_qu?(word) do
    if (starts_with_consonant?(word)) do
      # offset for q
      count = get_leading_consonants_count(word) - 1
      <<_head::binary-size(count), tail::binary>> = word
      String.starts_with?(tail, "qu")
    else
      false
    end
  end

  defp starts_with_y_after_consonants?(word) do
    if (starts_with_consonant?(word)) do
      # offset for y
      count = get_leading_consonants_count(word) - 1
      <<_head::binary-size(count), tail::binary>> = word
      String.first(word) == "y"
    else
      false
    end
  end

  defp get_leading_consonants_count(word, acc \\ 0) do
    if (starts_with_consonant?(word)) do
      <<_head::binary-size(1), tail::binary>> = word
      get_leading_consonants_count(tail, acc + 1)
    else
      acc
    end
  end
end
