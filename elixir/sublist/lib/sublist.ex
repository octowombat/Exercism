defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, a) when is_list(a), do: :equal
  def compare([], b) when is_list(b), do: :sublist
  def compare(a, []) when is_list(a), do: :superlist

  def compare(a, b) when is_list(a) and is_list(b) do
    cond do
      length(a) < length(b) ->
        if equal?(b, a), do: :sublist, else: :unequal

      length(b) < length(a) ->
        if equal?(a, b), do: :superlist, else: :unequal

      true ->
        # Same length lists have to be unequal
        :unequal
    end
  end

  defp equal?(l1, l2) when length(l1) == length(l2) do
    l1 === l2
  end

  defp equal?(l1, l2) do
    n = length(l2)
    [_ | t] = l1
    sub = take(n, l1)
    if sub === l2, do: true, else: equal?(t, l2)
  end

  defp take(n, list) do
    [h | t] = list
    do_take(n, t, 1, [h])
  end

  defp do_take(n, _, n, acc), do: Enum.reverse(acc)

  defp do_take(n, list, c, acc) when c < n do
    [h | t] = list

    do_take(n, t, c + 1, [h | acc])
  end
end
