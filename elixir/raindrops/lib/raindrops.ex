defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) when is_integer(number) and number >= 0 do
    for factor <- [7, 5, 3], reduce: "" do
      acc ->
        case Integer.mod(number, factor) do
          0 -> sound(factor) <> acc
          _ -> acc
        end
    end
    |> case do
      "" -> to_string(number)
      result -> result
    end
  end

  defp sound(3), do: "Pling"
  defp sound(5), do: "Plang"
  defp sound(7), do: "Plong"
end
