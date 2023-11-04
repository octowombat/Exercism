defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  require Integer

  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    do_factorise(number, [], 3)
  end

  defp do_factorise(1, factors, _), do: factors

  defp do_factorise(number, factors, prime) when Integer.is_even(number) do
    do_factorise(div(number, 2), factors ++ [2], prime)
  end

  defp do_factorise(number, factors, prime) do
    if rem(number, prime) == 0 do
      do_factorise(div(number, prime), factors ++ [prime], prime)
    else
      do_factorise(number, factors, next_candidate_prime(prime))
    end
  end

  defp next_candidate_prime(n) do
    n + 2
  end
end
