defmodule WineCellar do
  @spec explain_colors() :: Keyword.t()
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  @spec filter(cellar :: Keyword.t(), wine_colour :: atom(), opts :: Keyword.t()) :: list()
  def filter(cellar, color, opts \\ [])
      when is_list(cellar) and color in [:red, :rose, :white] and is_list(opts) do
    cellar
    |> Keyword.get_values(color)
    |> maybe_filter_by_year(opts[:year])
    |> maybe_filter_by_country(opts[:country])
  end

  defp maybe_filter_by_year(wines, nil), do: wines
  defp maybe_filter_by_year(wines, year) when is_integer(year), do: filter_by_year(wines, year)

  defp maybe_filter_by_country(wines, nil), do: wines

  defp maybe_filter_by_country(wines, country) when is_binary(country),
    do: filter_by_country(wines, country)

  # The functions below do not need to be modified.
  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
