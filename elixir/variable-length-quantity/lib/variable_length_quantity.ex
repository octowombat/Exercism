defmodule VariableLengthQuantity do
  @doc """
  Encode integers into a bitstring of VLQ encoded bytes
  """
  @zeros List.duplicate(0, 7)

  @spec encode(integers :: [integer]) :: binary
  def encode(integers) do
    integers
    |> Enum.reverse()
    |> Enum.reduce(<<>>, &encode_integer/2)
  end

  defp encode_integer(value, acc) when is_integer(value) and is_binary(acc) do
    value
    |> byte_split()
    |> add_most_significant_bit()
    |> compose(acc)
  end

  defp byte_split(value) when is_integer(value) do
    value
    |> Integer.digits(2)
    |> Enum.reverse()
    |> Enum.chunk_every(7, 7, @zeros)
    |> Enum.map(&Enum.reverse/1)
  end

  defp add_most_significant_bit([bit_list]) when is_list(bit_list),
    do: [List.insert_at(bit_list, 0, 0)]

  defp add_most_significant_bit([high | rest]) when is_list(high) and is_list(rest) do
    [List.insert_at(high, 0, 0) | Enum.map(rest, &List.insert_at(&1, 0, 1))]
  end

  defp compose(bytes, acc) when is_list(bytes) and is_binary(acc),
    do: Enum.reduce(bytes, acc, &composer/2)

  defp composer(bit_list, acc) when is_list(bit_list) and is_binary(acc),
    do: <<Integer.undigits(bit_list, 2), acc::binary>>

  @doc """
  Decode a bitstring of VLQ encoded bytes into a series of integers
  """
  @spec decode(bytes :: binary) :: {:ok, [integer]} | {:error, String.t()}
  def decode(_bytes) do
  end
end
