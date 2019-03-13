defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
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
