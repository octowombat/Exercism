defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna) when is_binary(rna) do
    proteins =
      rna
      |> String.codepoints()
      |> Enum.chunk_while([], &chunker/2, &remainder/1)

    case Enum.any?(proteins, &match?({:error, _}, &1)) do
      false -> {:ok, proteins}
      true -> {:error, "invalid RNA"}
    end
  end

  defp chunker(letter, word) when length(word) == 2 do
    codon = [letter | word] |> Enum.reverse() |> Enum.join()

    case of_codon(codon) do
      {:ok, "STOP"} -> {:halt, []}
      {:ok, codon} -> {:cont, codon, []}
      {:error, _reason} = err -> {:halt, err}
    end
  end

  defp chunker(letter, word), do: {:cont, [letter | word]}

  defp remainder([]), do: {:cont, []}
  defp remainder(_over), do: {:cont, {:error, "invalid codon"}, []}

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) do
    translate_codon(codon)
  end

  defp translate_codon(codon) when codon in ["UCA", "UCC", "UCU", "UCG"], do: {:ok, "Serine"}
  defp translate_codon(codon) when codon in ["UAA", "UAG", "UGA"], do: {:ok, "STOP"}
  defp translate_codon(codon) when codon in ["UGU", "UGC"], do: {:ok, "Cysteine"}
  defp translate_codon(codon) when codon in ["UUA", "UUG"], do: {:ok, "Leucine"}
  defp translate_codon(codon) when codon in ["UUU", "UUC"], do: {:ok, "Phenylalanine"}
  defp translate_codon(codon) when codon in ["UAU", "UAC"], do: {:ok, "Tyrosine"}
  defp translate_codon("AUG"), do: {:ok, "Methionine"}
  defp translate_codon("UGG"), do: {:ok, "Tryptophan"}
  defp translate_codon(_), do: {:error, "invalid codon"}
end
