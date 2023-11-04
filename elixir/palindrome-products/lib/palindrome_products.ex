defmodule PalindromeProducts do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1)

  def generate(max_factor, min_factor) when min_factor <= max_factor do
    range = min_factor..max_factor

    range
    |> candidates()
    |> factorise(range)
  end

  def generate(_max_factor, _min_factor), do: raise(%ArgumentError{})

  defp candidates(range) do
    for i <- range, j <- range do
      i * j
    end
    |> Enum.uniq()
    |> Enum.map(&Integer.digits/1)
    |> Enum.filter(&(&1 == Enum.reverse(&1)))
    |> Enum.map(&Integer.undigits/1)
  end

  defp factorise(palindromes, range) do
    Enum.into(palindromes, %{}, &factoring(&1, range))
  end

  defp factoring(palindrome, range) do
    {
      palindrome,
      palindrome |> factors(range) |> Enum.uniq()
    }
  end

  defp factors(1, _range), do: [[1, 1]]

  defp factors(number, range) do
    for factor <- range,
        gcd = Integer.gcd(number, factor),
        gcd != 1,
        ratio = div(number, gcd),
        ratio in range and ratio <= gcd,
        into: [] do
      [ratio, gcd]
    end
  end
end
