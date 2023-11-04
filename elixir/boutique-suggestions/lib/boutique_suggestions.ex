defmodule BoutiqueSuggestions do
  @spec get_combinations(list(), list(), Keyword.t()) :: [{map(), map()}]
  def get_combinations(tops, bottoms, options \\ [])
      when is_list(tops) and is_list(bottoms) and is_list(options) do
    max_price = Keyword.get(options, :maximum_price, 100.0)

    for top <- tops,
        bottom <- bottoms,
        top.base_color != bottom.base_color and top.price + bottom.price <= max_price,
        do: {top, bottom}
  end
end
