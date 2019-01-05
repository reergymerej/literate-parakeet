defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    # split into words
    # count them up
    sentence
    |> String.split(" ", trim: true)
    |> Enum.reduce(Map.new(), fn(x, acc) ->
      do_count(x, acc)
      end)
  end

  defp do_count(word, acc) do
    acc = Map.put(acc, word, 1)
  end
end
