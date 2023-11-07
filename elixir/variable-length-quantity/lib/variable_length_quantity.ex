defmodule VariableLengthQuantity do
  @doc """
  Encode integers into a bitstring of VLQ encoded bytes
  """
  @zeros List.duplicate(0, 8)

  import Bitwise

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
  def decode(bytes) when is_binary(bytes) do
    {remaining, result} =
      for <<byte::size(8) <- bytes>>, reduce: {<<>>, []} do
        {bin, list} ->
          <<msb::size(1), _rest::size(7)>> = <<byte>>

          bitstring = bin <> <<byte::size(8)>>

          case msb do
            1 ->
              {bitstring, list}

            0 ->
              {:ok, answer} = decode_value(bitstring)
              {<<>>, list ++ answer}
          end
      end

    case remaining do
      <<>> -> {:ok, result}
      _ -> {:error, "incomplete sequence"}
    end
  end

  defp decode_value(bytes) when is_binary(bytes) do
    result =
      for <<c::size(8) <- bytes>>, reduce: 0 do
        acc ->
          case c &&& 0x80 do
            0 ->
              acc <<< 7 ||| c

            _ ->
              v = c &&& 0x7F
              acc <<< 7 ||| v
          end
      end

    {:ok, [result]}
  end
end
