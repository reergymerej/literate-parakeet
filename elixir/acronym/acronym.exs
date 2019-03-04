defmodule Acronym do
  @regex ~r/([A-Z]| [a-z])/

  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    Regex.scan(@regex, string)
      |> Enum.map(&get_letter_from_list/1)
      |> Enum.join()
  end

  defp get_letter_from_list(list) do
    List.first(list)
      |> String.trim()
      |> String.upcase()
  end
end
