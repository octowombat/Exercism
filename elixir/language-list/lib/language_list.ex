defmodule LanguageList do
  @exciting_language "Elixir"

  def new do
    []
  end

  def add(list, language) when is_list(list) and is_binary(language) do
    [language | list]
  end

  def remove(list) when is_list(list) do
    [h | t] = list
    t
  end

  def first(list) when is_list(list) do
    [first | _] = list
    first
  end

  def count(list) when is_list(list) do
    length(list)
  end

  def exciting_list?(list) when is_list(list), do: @exciting_language in list
end
