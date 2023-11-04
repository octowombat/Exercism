defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(1), do: 1

  def calculate(radicand) do
    intial_estimate = div(radicand, 2)
    do_calculate(radicand, intial_estimate, intial_estimate)
  end

  defp do_calculate(_, root, 0), do: root

  defp do_calculate(radicand, estimate, _) do
    better_estimate = div(estimate + div(radicand, estimate), 2)
    do_calculate(radicand, better_estimate, abs(better_estimate - estimate))
  end
end
