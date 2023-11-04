defmodule BirdCount do
  def today([]), do: nil

  def today([headcount | _other_days]) when is_integer(headcount), do: headcount

  def increment_day_count([]), do: [1]
  def increment_day_count([headcount | other_days]), do: [headcount + 1 | other_days]

  def has_day_without_birds?(bird_counts) when is_list(bird_counts), do: zero_day?(bird_counts)

  def total(bird_counts) when is_list(bird_counts), do: sum(bird_counts)

  def busy_days(bird_counts) when is_list(bird_counts), do: busy_count(bird_counts)

  defp sum([]), do: 0
  defp sum([headcount | other_days]), do: headcount + sum(other_days)

  defp zero_day?([]), do: false
  defp zero_day?([0 | other_days]), do: true or zero_day?(other_days)
  defp zero_day?([_ | other_days]), do: false or zero_day?(other_days)

  defp count([]), do: 0
  defp count([_ | rest]), do: 1 + count(rest)

  defp busy_count([]), do: 0
  defp busy_count([h | rest]) when h > 4, do: 1 + busy_count(rest)
  defp busy_count([_ | rest]), do: busy_count(rest)
end
