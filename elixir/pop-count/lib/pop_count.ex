defmodule PopCount do
  @doc """
  Given the number, count the number of eggs.
  """
  @spec egg_count(number :: integer()) :: non_neg_integer()
  def egg_count(0), do: 0

  def egg_count(number) when is_integer(number) and number > 0 do
    number
    |> Integer.to_charlist(2)
    |> Enum.count(&(&1 == ?1))
  end
end
