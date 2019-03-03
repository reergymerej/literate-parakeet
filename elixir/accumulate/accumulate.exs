defmodule Accumulate do
  @doc """
    Given a list and a function, apply the function to each list item and
    replace it with the function's return value.

    Returns a list.

    ## Examples

      iex> Accumulate.accumulate([], fn(x) -> x * 2 end)
      []

      iex> Accumulate.accumulate([1, 2, 3], fn(x) -> x * 2 end)
      [2, 4, 6]

  """

  @spec accumulate(list, (any -> any)) :: list
  def accumulate(list, fun) do
    get_val([], list, fun)
  end

  defp get_val(acc, [], fun) do
    acc
  end

  defp get_val(acc, [head | tail], fun) do
    acc = acc ++ [fun.(head)]
    get_val(acc, tail, fun)
  end
end
