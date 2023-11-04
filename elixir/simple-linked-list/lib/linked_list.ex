defmodule LinkedList do
  @opaque t :: %{any() => tuple()}

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new do
    {}
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push({}, elem), do: {elem}

  def push(list, elem) when is_tuple(list) do
    Tuple.append(list, elem)
  end

  @doc """
  Counts the number of elements in a LinkedList
  """
  @spec count(t) :: non_neg_integer()
  def count({}), do: 0

  def count(list) when is_tuple(list) do
    tuple_size(list)
  end

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?({}), do: true

  def empty?(list) when is_tuple(list) do
    tuple_size(list) == 0
  end

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek({}), do: {:error, :empty_list}

  def peek(list) when is_tuple(list) do
    size = count(list)
    v = elem(list, size - 1)
    {:ok, v}
  end

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail({}), do: {:error, :empty_list}

  def tail(list) when is_tuple(list) do
    size = count(list)
    tail = Tuple.delete_at(list, size - 1)
    {:ok, tail}
  end

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop({}), do: {:error, :empty_list}

  def pop(list) when is_tuple(list) do
    {:ok, head} = peek(list)
    {:ok, tail} = tail(list)
    {:ok, head, tail}
  end

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list([]), do: {}

  def from_list(list) when is_list(list) do
    do_from_list(list, new())
  end

  defp do_from_list([], acc), do: reverse(acc)

  defp do_from_list([h | t], acc) do
    do_from_list(t, push(acc, h))
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list({}), do: []

  def to_list(list) when is_tuple(list) do
    do_to_list(list, [])
  end

  defp do_to_list({}, acc), do: acc

  defp do_to_list(list, acc) do
    {:ok, head, tail} = pop(list)
    do_to_list(tail, acc ++ [head])
  end

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse({}), do: {}

  def reverse(list) when is_tuple(list) do
    do_reverse(list, {})
  end

  defp do_reverse({}, acc), do: acc

  defp do_reverse(list, acc) do
    {:ok, head, tail} = pop(list)
    do_reverse(tail, push(acc, head))
  end
end
