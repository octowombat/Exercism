defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, a, a) when a > 0, do: {:ok, :equilateral}
  def kind(a, a, a) when a > 0, do: {:ok, :equilateral}
  def kind(a, a, c) when a > 0 and c > 0 and 2 * a >= c, do: {:ok, :isosceles}
  def kind(a, b, a) when a > 0 and b > 0 and 2 * a >= b, do: {:ok, :isosceles}
  def kind(a, b, b) when a > 0 and b > 0 and 2 * b >= a, do: {:ok, :isosceles}

  def kind(a, b, c) when a <= 0 or b <= 0 or c <= 0,
    do: {:error, "all side lengths must be positive"}

  def kind(a, b, c) when a > 0 and b > 0 and c > 0 and a + b >= c and b + c >= a and a + c >= b do
    {:ok, :scalene}
  end

  def kind(_, _, _), do: {:error, "side lengths violate triangle inequality"}
end
