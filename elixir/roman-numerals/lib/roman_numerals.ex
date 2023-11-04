defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    {result, 0} =
      for p <- [1000, 100, 10, 1], reduce: {"", number} do
        {numerals, remainder} ->
          {
            numerals <> roman_numeral(div(remainder, p), p),
            rem(remainder, p)
          }
      end

    result
  end

  defp roman_numeral(0, _), do: ""
  defp roman_numeral(1, 1), do: "I"
  defp roman_numeral(2, 1), do: "II"
  defp roman_numeral(3, 1), do: "III"
  defp roman_numeral(4, 1), do: "IV"
  defp roman_numeral(5, 1), do: "V"
  defp roman_numeral(6, 1), do: "VI"
  defp roman_numeral(7, 1), do: "VII"
  defp roman_numeral(8, 1), do: "VIII"
  defp roman_numeral(9, 1), do: "IX"
  defp roman_numeral(1, 10), do: "X"
  defp roman_numeral(2, 10), do: "XX"
  defp roman_numeral(3, 10), do: "XXX"
  defp roman_numeral(4, 10), do: "XL"
  defp roman_numeral(5, 10), do: "L"
  defp roman_numeral(6, 10), do: "LX"
  defp roman_numeral(7, 10), do: "LXX"
  defp roman_numeral(8, 10), do: "LXXX"
  defp roman_numeral(9, 10), do: "XC"
  defp roman_numeral(1, 100), do: "C"
  defp roman_numeral(2, 100), do: "CC"
  defp roman_numeral(3, 100), do: "CCC"
  defp roman_numeral(4, 100), do: "CD"
  defp roman_numeral(5, 100), do: "D"
  defp roman_numeral(6, 100), do: "DC"
  defp roman_numeral(7, 100), do: "DCC"
  defp roman_numeral(8, 100), do: "DCCC"
  defp roman_numeral(9, 100), do: "CM"
  defp roman_numeral(1, 1000), do: "M"
  defp roman_numeral(2, 1000), do: "MM"
  defp roman_numeral(3, 1000), do: "MMM"
end
