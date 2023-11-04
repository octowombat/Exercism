defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_digits, input_base, _output_base) when is_integer(input_base) and input_base < 2,
    do: {:error, "input base must be >= 2"}

  def convert(_digits, _input_base, output_base) when is_integer(output_base) and output_base < 2,
    do: {:error, "output base must be >= 2"}

  def convert([], _input_base, _output_base), do: {:ok, [0]}
  def convert([0], _input_base, _output_base), do: {:ok, [0]}

  def convert(digits, input_base, output_base)
      when is_list(digits) and is_integer(input_base) and is_integer(output_base) and
             input_base > 1 and output_base > 1 do
    case valid?(digits, input_base) do
      false ->
        {:error, "all digits must be >= 0 and < input base"}

      true ->
        {
          :ok,
          digits |> reverse() |> decimal(input_base) |> base(output_base)
        }
    end
  end

  defp valid?(digits, base) do
    Enum.all?(digits, &(&1 >= 0 and &1 < base))
  end

  defp reverse(list), do: reverse(list, [])
  defp reverse([], acc), do: acc

  defp reverse([h | t], acc) do
    reverse(t, [h | acc])
  end

  defp decimal([h | t], base) do
    to_decimal(t, base, {base, h})
  end

  defp to_decimal([], _base, {_factor, value}), do: value

  defp to_decimal([h | t], base, {factor, value}),
    do: to_decimal(t, base, {factor * base, value + h * factor})

  defp base(0, _base), do: [0]

  defp base(decimal, base) do
    mp = max_power(decimal, base)
    to_base(decimal, mp, base, [])
  end

  defp max_power(decimal, base), do: floor(:math.log(decimal) / :math.log(base))

  defp to_base(0, -1, _base, list), do: reverse(list)

  defp to_base(remainder, power, base, acc) do
    scale = Integer.pow(base, power)
    factor = div(remainder, scale)
    leftover = remainder - scale * factor
    to_base(leftover, power - 1, base, [factor | acc])
  end
end
