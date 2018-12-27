defmodule NucleotideCount do
  # What is this?  It looks like some sort of module-scoped variable.
  # https://elixir-lang.org/getting-started/module-attributes.html#as-constants
  # This is a "module attribute," a concept from Erlang.  It is often used as a
  # "constant."
  @nucleotides [?A, ?C, ?G, ?T]

  # @doc - provides documentation for the function or macro that follows the attribute.
  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  # Typespec, takes a list of char and a char, returns non-negative integer
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    # How does Enum.count work?
    # There are two variations:
    # @spec count(t()) :: non_neg_integer()
    # @spec count(t(), (element() -> as_boolean(term()))) :: non_neg_integer()
    #
    # This is the 2nd one.  The 2nd arg is a function
    # element() -> as_boolean(term())
    # as_boolean(t)	t
    # term()	any()
    #
    # How does &(&1 == nucleotide) do that?
    #
    # &1 == nucleotide --- generates a boolean, but what does & mean?
    # & is the "CAPTURE FUNCTION"
    # It can be used to create an anonymous function.
    # add_one = &(&1 + 1)
    # is the same as
    # add_one = fn x -> x + 1 end
    #
    # &1 is a value placeholder. It identifies the nth argument of the function.
    # https://dockyard.com/blog/2016/08/05/understand-capture-operator-in-elixir
    Enum.count(strand, &(&1 == nucleotide))
    # It could have been
    # Enum.count(strand, fn(x) -> (x == nucleotide) end)
  end





  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  # This is a typespec.
  # https://hexdocs.pm/elixir/typespecs.html
  # Takes a list of chars, returns a map.
  @spec histogram([char]) :: map
  def histogram(strand) do
    Map.new(@nucleotides, &({&1, count(strand, &1)}))
    # Now that we understand the capture function, we can read this.
    # &({&1, count(strand, &1)})
    # fn(x) -> { x, count(strand, x) } end
    # This is returning a tuple for each @nucleotides, using our count fn.
    #
    #  @spec new(Enumerable.t(), (term() -> {key(), value()})) :: map()
    #  Creates a map from an enumerable via the given transformation function.
  end
end
