# https://exercism.io/tracks/elixir/exercises/protein-translation/solutions/46a8fdbee7fa4701985d4e9e5358e58b

# module definition
# defmodule is a macro
defmodule ProteinTranslation do
  # documentation for of_rna
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  # typespec, takes a string, returns tuple of  atom and list of strings
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }

  # of_rna function, calls do_of_rna with string and empty list
  def of_rna(rna), do: do_of_rna(rna, [])

  # private function
  # << ... >>  This is a way to refer to binaries.
  # :: I'm not sure what this does.  The code seems to take the first 3
  # characters and spreads the rest.
  # https://elixir-lang.org/getting-started/binaries-strings-and-char-lists.html#binaries-and-bitstrings
  #
  # h(::/2) - defmacro left :: right
  # Used by types and bitstrings to specify types.
  #
  #
  # Binaries allow modifiers to be given to store numbers bigger than 255 or to convert a code point to its UTF-8 representation:
  #  size(16), use 16 bits (2 bytes) to store the number
  #
  # iex(53)> <<255 :: size(8)>>
  # <<255>>
  # iex(54)> <<255 :: size(16)>>
  # <<0, 255>>
  # iex(55)> <<255 :: size(32)>>
  # <<0, 0, 0, 255>>
  # iex(56)> <<255 :: size(64)>>
  # <<0, 0, 0, 0, 0, 0, 0, 255>>
  # iex(57)> <<256 :: size(8)>>
  # <<0>>
  # iex(58)> <<256 :: size(16)>>
  # <<1, 0>>
  # iex(59)> <<256 :: size(32)>>
  # <<0, 0, 1, 0>>
  # iex(60)> <<256 :: size(64)>>
  # <<0, 0, 0, 0, 0, 0, 1, 0>>#
  #
  # What does size do?  I don't see any documentation for that elsewhere.  It's
  # probably just for binary manipulation.
  #
  # https://stackoverflow.com/a/41134210/1319850
  # This explains it very well.
  # I can see the docs by h(<< >>)
  # It's a macro to define a new bitstring.
  # https://hexdocs.pm/elixir/Kernel.SpecialForms.html#%3C%3C%3E%3E/1
  #
  #
  # <<codon::binary-size(3), rest::binary>>
  # << >> is a special form for making bitstrings.
  # They are a bunch of segments, each with a type.
  # When not specified, the type is integer.
  #
  #
  # binary and size are options for the << >> (bitstring)
  # Options are separated by -
  #
  # binary is the type of the segment
  # size(3) means
  #
  #
  # We can use pattern matching to split apart binaries/bitstrings!
  # iex(28)> <<h::binary-size(5), t::binary>> = "abcdefghijklmnopqrstuvwxyz"
  # "abcdefghijklmnopqrstuvwxyz"
  # iex(29)> h
  # "abcde"
  # iex(30)> t
  #
  # There is a lot to explore here.  In short, we can pattern match a bitstring,
  # splitting it at a certain length, like substring in other languages.
  #
  # codon is the first 3 binary values.
  # The remaining values are assigned to "rest".
  # Both have to specify "binary" so they are not received as integers.
  # The last segment does not need to specify size.
  #
  # accumulator
  #
  defp do_of_rna(<<codon::binary-size(3), rest::binary>>, acc) do
    # Look up the protein for the codon.
    case of_codon(codon) do
      # found something bad, bail
      {:error, _} -> {:error, "invalid RNA"}
      # found the end, return what we've got
      {:ok, "STOP"} -> {:ok, acc}
      # all good, recurse the rest
      {:ok, protein} -> do_of_rna(rest, acc ++ [protein])
    end
  end

  # When using pattern matching to split the bitstring, if there is nothing
  # remaining, "rest" will be "".
  defp do_of_rna("", acc), do: {:ok, acc}

  @proteins %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP",
  }

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    case Map.fetch(@proteins, codon) do
      :error -> {:error, "invalid codon"}
      {:ok, _} = value -> value
    end
  end
end
