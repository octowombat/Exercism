defmodule DNA do
  @dna_codes %{?\s => 0b0000, ?A => 0b001, ?C => 0b0010, ?G => 0b0100, ?T => 0b1000}
  @nucleic_acid Map.keys(@dna_codes)
  @nucleic_acid_codes Map.values(@dna_codes)

  def encode_nucleotide(code_point) when code_point in @nucleic_acid do
    @dna_codes[code_point]
  end

  def decode_nucleotide(encoded_code) when encoded_code in @nucleic_acid_codes do
    do_find_value(encoded_code, Map.to_list(@dna_codes))
  end

  defp do_find_value(encoded_code, [{code_point, encoded_code} | _]), do: code_point
  defp do_find_value(encoded_code, [{_, _} | rest]), do: do_find_value(encoded_code, rest)

  def encode(dna) when is_list(dna) do
    [h | t] = dna
    do_encode(t, <<encode_nucleotide(h)::4>>)
  end

  def decode(dna) when is_bitstring(dna) do
    <<b::4, rest::bitstring>> = dna
    do_decode(rest, [decode_nucleotide(b)])
  end

  defp do_encode([], acc) when is_bitstring(acc), do: acc

  defp do_encode(l, acc) when is_list(l) and is_bitstring(acc) do
    [h | t] = l

    f = <<encode_nucleotide(h)::4>>

    do_encode(t, <<acc::bitstring, f::bitstring>>)
  end

  defp do_decode(<<>>, acc) when is_list(acc), do: acc

  defp do_decode(encoded, acc) when is_bitstring(encoded) and is_list(acc) do
    <<b::4, rest::bitstring>> = encoded
    n = decode_nucleotide(b)
    do_decode(rest, acc ++ [n])
  end
end
