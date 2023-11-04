defmodule Allergies do
  import Bitwise

  @allergens %{
    eggs: 0b00000001,
    peanuts: 0b00000010,
    shellfish: 0b00000100,
    strawberries: 0b00001000,
    tomatoes: 0b00010000,
    chocolate: 0b00100000,
    pollen: 0b01000000,
    cats: 0b10000000
  }

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) when is_integer(flags) and flags >= 0 do
    @allergens
    |> Enum.filter(fn {_allergen, code} -> (flags &&& code) == code end)
    |> Enum.map(fn {allergen, _code} -> Atom.to_string(allergen) end)
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(0, _item), do: false

  def allergic_to?(flags, item) when is_integer(flags) and flags > 0 and is_binary(item) do
    allergen = Map.fetch!(@allergens, String.to_existing_atom(item))
    (flags &&& allergen) == allergen
  end
end
