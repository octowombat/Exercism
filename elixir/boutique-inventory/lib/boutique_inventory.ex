defmodule BoutiqueInventory do
  def sort_by_price([]), do: []

  def sort_by_price(inventory) when is_list(inventory) do
    Enum.sort_by(inventory, & &1.price)
  end

  def with_missing_price([]), do: []

  def with_missing_price(inventory) when is_list(inventory) do
    Enum.filter(inventory, &(Map.has_key?(&1, :price) and is_nil(&1.price)))
  end

  def update_names([], _old_word, _new_word), do: []

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      case String.contains?(item.name, old_word) do
        true -> %{item | name: String.replace(item.name, old_word, new_word)}
        false -> item
      end
    end)
  end

  def increase_quantity(%{quantity_by_size: quantities} = item, count)
      when is_map(quantities) and is_integer(count) and count > 0 do
    %{
      item
      | quantity_by_size:
          Map.new(quantities, fn {size, quantity} ->
            {size, quantity + count}
          end)
    }
  end

  def total_quantity(item) when item == %{}, do: 0

  def total_quantity(%{quantity_by_size: quantities}) when is_map(quantities) do
    Enum.reduce(quantities, 0, fn {_size, quantity}, sum -> sum + quantity end)
  end
end
