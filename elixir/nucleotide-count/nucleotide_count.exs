defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    case Map.fetch(histogram(strand), nucleotide) do
      {:ok, val} -> val
    end
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    map = %{?A => 0, ?C => 0, ?G => 0, ?T => 0}
    Enum.reduce(strand, map, fn(x, acc) ->
      case x do
        ?A -> %{ acc | ?A => acc[?A] + 1 }
        ?C -> %{ acc | ?C => acc[?C] + 1 }
        ?G -> %{ acc | ?G => acc[?G] + 1 }
        ?T -> %{ acc | ?T => acc[?T] + 1 }
      end
    end)
  end
end
