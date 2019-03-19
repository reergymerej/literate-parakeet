defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(string :: String.t(), size :: integer) :: list(String.t())
  def slices(_string, size) when size <= 0 do
    []
  end

  def slices(string, size) do
    string_length = String.length(string)

    if (size > string_length) do
      []
    else
      slice_count = string_length - size
      slice_range = 0..slice_count

      Enum.map(slice_range, fn (x) ->
          String.slice(string, x, size)
      end)
    end
  end
end
