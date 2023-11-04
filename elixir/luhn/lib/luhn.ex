defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @valid_ex ~r/[^\d\s]|^[0\s]{1,2}$/

  @spec valid?(String.t()) :: boolean
  def valid?(number) when is_binary(number) do
    # Immediately reject invalid strings
    case invalid_string?(number) do
      true ->
        false

      false ->
        # Validate according to Luhn rules
        luhn_valid?(number)
    end
  end

  defp invalid_string?(text) do
    Regex.match?(@valid_ex, text)
  end

  defp luhn_valid?(number) do
    total =
      number
      |> String.codepoints()
      |> Enum.reject(&String.match?(&1, ~r/\s/))
      |> Enum.map(&String.to_integer/1)
      |> Enum.reverse()
      |> List.insert_at(0, 0)
      |> Enum.map_every(2, &doubling_rule/1)
      |> Enum.sum()

    rem(total, 10) == 0
  end

  defp doubling_rule(value) when 2 * value > 9, do: 2 * value - 9
  defp doubling_rule(value), do: 2 * value
end
