defmodule Knapsack do
  @doc """
  Return the maximum value that a knapsack can carry.
  """
  @spec maximum_value(items :: [%{value: integer, weight: integer}], maximum_weight :: integer) ::
          integer
  def maximum_value([], _maximum_weight), do: 0
  def maximum_value([%{weight: w}], maximum_weight) when w > maximum_weight, do: 0
  def maximum_value([%{value: v, weight: w}], maximum_weight) when w <= maximum_weight, do: v

  def maximum_value(items, maximum_weight)
      when is_list(items) and is_integer(maximum_weight) and maximum_weight >= 0 do
    dp = for _ <- 0..(maximum_weight + 1), do: 0
    knapsack(items, maximum_weight, dp, 1)
  end

  defp knapsack(items, maximum_weight, dp, i) when i == length(items) + 1,
    do: Enum.at(dp, maximum_weight)

  defp knapsack(items, maximum_weight, dp, i) do
    updated_dp = inner(items, dp, i, maximum_weight)
    knapsack(items, maximum_weight, updated_dp, i + 1)
  end

  defp inner(_, dp, _, -1), do: dp

  defp inner(items, dp, i, w) do
    item_weight = Enum.at(items, i - 1).weight

    updated_dp =
      if item_weight <= w do
        %{weight: weight, value: v} = Enum.at(items, i - 1)

        m =
          max(
            Enum.at(dp, w),
            Enum.at(dp, w - weight) + v
          )

        List.replace_at(dp, w, m)
      else
        dp
      end

    inner(items, updated_dp, i, w - 1)
  end
end
