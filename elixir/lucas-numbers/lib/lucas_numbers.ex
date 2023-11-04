defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """
  @spec generate(pos_integer()) :: list(pos_integer())
  def generate(count)
      when not is_integer(count)
      when count < 1 do
    raise ArgumentError, "count must be specified as an integer >= 1"
  end

  def generate(1), do: [2]
  def generate(2), do: [2, 1]

  def generate(count) do
    [first, second] = generate(2)

    rest =
      Stream.unfold({3, 1, 2}, fn
        {n, i, j} when n <= count ->
          {i + j, {n + 1, i + j, i}}

        {n, _last, _last_but_one} when n > count ->
          nil
      end)
      |> Enum.to_list()

    [first, second | rest]
  end
end
