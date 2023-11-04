defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0

  def count(l) when is_list(l) do
    do_count(l, 0)
  end

  @spec reverse(list) :: list
  def reverse([]), do: []

  def reverse(l) when is_list(l) do
    do_reverse(l, [])
  end

  @spec map(list, (any -> any)) :: list
  def map([], _), do: []

  def map(l, f) when is_list(l) and is_function(f, 1) do
    l |> do_map(f, []) |> reverse()
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _f), do: []

  def filter(l, f) when is_list(l) and is_function(f, 1) do
    l |> do_filter(f, []) |> reverse()
  end

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl([], acc, _f), do: acc

  def foldl(l, acc, f) when is_list(l) and is_function(f, 2) do
    do_foldl(l, acc, f)
  end

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr([], acc, _f), do: acc

  def foldr(l, acc, f) do
    l |> reverse() |> foldl(acc, f)
  end

  @spec append(list, list) :: list
  def append(a, []) when is_list(a), do: a
  def append([], b) when is_list(b), do: b

  def append(a, b) when is_list(a) and is_list(b) do
    a |> reverse() |> do_append(b)
  end

  @spec concat([[any]]) :: [any]
  def concat([]), do: []

  def concat(ll) when is_list(ll) do
    ll |> do_concat([]) |> reverse()
  end

  defp do_count([], acc), do: acc

  defp do_count(l, acc) do
    [_h | t] = l
    do_count(t, acc + 1)
  end

  defp do_reverse([], acc), do: acc

  defp do_reverse(l, acc) do
    [h | t] = l
    do_reverse(t, [h | acc])
  end

  defp do_map([], _, acc), do: acc

  defp do_map(l, f, acc) do
    [h | t] = l
    do_map(t, f, [f.(h) | acc])
  end

  defp do_filter([], _, acc), do: acc

  defp do_filter(l, f, acc) do
    [h | t] = l
    if f.(h), do: do_filter(t, f, [h | acc]), else: do_filter(t, f, acc)
  end

  defp do_foldl([], acc, _f), do: acc

  defp do_foldl(l, acc, f) do
    [h | t] = l
    do_foldl(t, f.(h, acc), f)
  end

  defp do_append([], acc), do: acc

  defp do_append(l, acc) do
    [h | t] = l
    do_append(t, [h | acc])
  end

  defp do_concat([], acc), do: acc

  defp do_concat(ll, acc) do
    [hl | tl] = ll

    if is_list(hl) do
      do_concat(tl, append(reverse(hl), acc))
    end
  end
end
