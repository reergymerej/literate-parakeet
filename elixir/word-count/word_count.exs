defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.replace(~r/_/i, " ")
    |> String.replace(~r/[:!,&@$%^]/i, "")
    |> String.split(" ", trim: true)
    |> Enum.reduce(Map.new(), fn(x, acc) ->
      word = String.downcase(x)
      do_count(word, acc)
      end)
  end

  defp do_count(word, acc) do
    if (Map.has_key?(acc, word)) do
      %{acc | word => Map.get(acc, word) + 1}
    else
      Map.put(acc, word, 1)
    end
  end
end
