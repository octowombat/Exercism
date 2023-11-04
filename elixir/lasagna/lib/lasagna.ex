defmodule Lasagna do
  @cooking_time_mins 40
  @layer_prep_time_mins 2

  def expected_minutes_in_oven, do: @cooking_time_mins

  def remaining_minutes_in_oven(mins_in_oven), do: expected_minutes_in_oven() - mins_in_oven

  def preparation_time_in_minutes(num_layers), do: @layer_prep_time_mins * num_layers

  def total_time_in_minutes(num_layers, mins_in_oven),
    do: preparation_time_in_minutes(num_layers) + mins_in_oven

  def alarm, do: "Ding!"
end
