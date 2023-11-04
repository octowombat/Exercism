defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten([]), do: []

  def flatten(list) when is_list(list) do
    do_flatten(list, [])
  end

  defp do_flatten([], acc), do: acc

  defp do_flatten(list, acc) do
    [h | t] = list

    cond do
      is_nil(h) ->
        do_flatten(t, acc)

      is_list(h) ->
        flattened = do_flatten(h, [])
        do_flatten(t, acc ++ flattened)

      true ->
        do_flatten(t, acc ++ [h])
    end
  end
end
