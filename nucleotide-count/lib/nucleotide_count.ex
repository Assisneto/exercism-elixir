defmodule NucleotideCount do
  # @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide) do
    acc = 0
    count(strand, nucleotide, acc)
  end

  def count([head | tail], nucleotide, acc) do
    cond do
      head == nucleotide -> count(tail, nucleotide, acc+1)
      true -> count(tail, nucleotide, acc)
    end
  end

  def count([], _nucleotide, acc) do
   acc
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand) do
    acc = %{?A => 0, ?T => 0, ?C => 0, ?G => 0}
    histogram(acc, strand)
  end

  def histogram(acc,[head | tail]) do
    Map.put(acc, head, (acc[head] || 0) + 1)
    |> histogram(tail)
  end

  def histogram(acc, []) do
    acc
  end

end
