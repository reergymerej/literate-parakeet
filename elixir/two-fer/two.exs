# https://exercism.io/tracks/elixir/exercises/two-fer/solutions/a850579412db49b5b5eab4ae053232fc
#
defmodule TwoFer do
  @doc """
  Two-fer or 2-fer is short for two for one. One for you and one for me.
  """
  @spec two_fer(String.t()) :: String.t()
  def two_fer(name \\ "you") when is_binary(name) do
    "One for #{name}, one for me"
  end
end
