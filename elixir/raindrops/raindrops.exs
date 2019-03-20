defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    result = add_pling("", number)
      |> add_plang(number)
      |> add_plong(number)
    if result == "" do
      to_string(number)
    else
      result
    end
  end

  defp add_pling(acc, number) do
    if has_prime_factor(number, 3) do
      acc <> "Pling"
    else
      acc
    end
  end

  defp add_plang(acc, number) do
    if has_prime_factor(number, 5) do
      acc <> "Plang"
    else
      acc
    end
  end

  defp add_plong(acc, number) do
    if has_prime_factor(number, 7) do
      acc <> "Plong"
    else
      acc
    end
  end

  @spec has_prime_factor(integer, integer) :: Boolean
  defp has_prime_factor(number, n) do
    rem(number, n) == 0
  end
end
