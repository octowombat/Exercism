defmodule KitchenCalculator do
  @ml :milliliter
  @supported_units [@ml, :cup, :fluid_ounce, :tablespoon, :teaspoon]

  def get_volume({_, volume}) when is_number(volume) and volume >= 0, do: volume

  def to_milliliter({@ml, volume} = measure) when is_number(volume) and volume >= 0,
    do: measure

  def to_milliliter({_, volume} = measure) when is_number(volume) and volume >= 0,
    do: convert_to(measure)

  def from_milliliter({@ml, volume} = measure, @ml) when is_number(volume) and volume >= 0,
    do: measure

  def from_milliliter({_, volume} = measure, unit)
      when is_number(volume) and volume >= 0 and unit in @supported_units,
      do: convert_from(measure, unit)

  def convert({from_unit, _} = measure, unit)
      when from_unit in @supported_units and unit in @supported_units do
    measure
    |> to_milliliter()
    |> from_milliliter(unit)
  end

  defp convert_to({unit, vol}), do: {@ml, vol * factor(unit)}
  defp convert_from({@ml, vol}, unit), do: {unit, vol / factor(unit)}

  defp factor(:cup), do: 240.0
  defp factor(:fluid_ounce), do: 30.0
  defp factor(:tablespoon), do: 15.0
  defp factor(:teaspoon), do: 5.0
end
