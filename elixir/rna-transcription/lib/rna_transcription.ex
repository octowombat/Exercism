defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

    iex> RnaTranscription.to_rna(~c"ACTG")
    ~c"UGAC"
  """
  @spec to_rna([char]) :: [char]
  def to_rna(~c""), do: ~c""

  def to_rna(dna) when is_list(dna) do
    Enum.map(dna, &transcribe/1)
  end

  defp transcribe(?A), do: ?U
  defp transcribe(?C), do: ?G
  defp transcribe(?G), do: ?C
  defp transcribe(?T), do: ?A
end
