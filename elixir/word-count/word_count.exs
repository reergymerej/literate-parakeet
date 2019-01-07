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
      do_count(x, acc)
      end)
  end

  defp do_count(word, acc) do
    down = String.downcase(word)
    if (Map.has_key?(acc, down)) do
      acc = %{acc | down => Map.get(acc, down) + 1 }
    else
      acc = Map.put(acc, down, 1)
    end
  end
end
