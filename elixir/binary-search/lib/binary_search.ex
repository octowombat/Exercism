defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """
  @not_found :not_found

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key, offset \\ 0)
  def search({}, _key, _), do: @not_found
  def search({number}, number, offset), do: {:ok, offset}
  def search({number}, _, _), do: @not_found

  def search(numbers, key, offset) when is_tuple(numbers) and is_integer(key) and offset >= 0 do
    midway = div(tuple_size(numbers), 2)
    midway_value = elem(numbers, midway)
    {left, right} = numbers |> Tuple.to_list() |> Enum.split(midway)

    cond do
      key == midway_value ->
        {:ok, midway + offset}

      key < midway_value ->
        search(List.to_tuple(left), key, 0)

      true ->
        search(List.to_tuple(right), key, offset + midway)
    end
  end
end
