defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    do_action(list, fun, [])
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    inverse_fun = &(not fun.(&1))
    do_action(list, inverse_fun, [])
  end

  defp do_action([], _fun, acc), do: acc

  defp do_action(list, fun, acc) do
    [h | t] = list
    if fun.(h), do: do_action(t, fun, acc ++ [h]), else: do_action(t, fun, acc)
  end
end
