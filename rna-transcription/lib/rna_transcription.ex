defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    List.to_string(dna)
      |> String.graphemes()
      |> Enum.map(fn (x)->
        case x do
          "G" -> 'C'
          "C" -> 'G'
          "T" -> 'A'
          "A" -> 'U'
          end
      end)
      |> Enum.join()
      |> String.to_charlist()
    end
end
