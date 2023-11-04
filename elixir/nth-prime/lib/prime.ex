defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise("No zeroth prime")
  def nth(1), do: 2

  def nth(count) when count > 1 do
    bracket(0, count, 2)
  end

  defp bracket(size, n, factor) when size > n do
    n
    |> sieve(factor)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sort()
    |> Enum.at(n - 1)
  end

  defp bracket(_size, n, factor) do
    n
    |> sieve(factor)
    |> Enum.count()
    |> bracket(n, factor + 1)
  end

  defp sieve(n, factor) do
    (factor * n)
    |> sieve_eratosthenes()
    |> Enum.filter(&elem(&1, 1))
  end

  defp sieve_eratosthenes(n) do
    candidates = for x <- 2..n, into: %{}, do: {x, true}

    for i <- 2..trunc(:math.sqrt(n)),
        candidates[i],
        j <- (i * i)..n//i,
        into: candidates,
        do: {j, false}
  end
end
