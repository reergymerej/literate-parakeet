defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.split(~r/[:!,&@$%^_ ]/i, trim: true)
    |> Enum.reduce(Map.new(), fn(word, acc) ->
      word
      |> String.downcase()
      |> do_count(acc)
      end)
  end

  defp do_count(word, acc) do
    Map.update(acc, word, 1, &(&1 + 1))
  end
end
