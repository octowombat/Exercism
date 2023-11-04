defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a_num, a_denom}, {b_num, b_denom})
      when is_integer(a_num) and is_integer(a_denom) and is_integer(b_num) and is_integer(b_denom) do
    reduce({a_num * b_denom + a_denom * b_num, a_denom * b_denom})
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a_num, a_denom}, {b_num, b_denom})
      when is_integer(a_num) and is_integer(a_denom) and is_integer(b_num) and is_integer(b_denom) do
    reduce({a_num * b_denom - a_denom * b_num, a_denom * b_denom})
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a_num, a_denom}, {b_num, b_denom})
      when is_integer(a_num) and is_integer(a_denom) and is_integer(b_num) and is_integer(b_denom) do
    reduce({a_num * b_num, a_denom * b_denom})
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a_num, a_denom}, {b_num, b_denom})
      when is_integer(a_num) and is_integer(a_denom) and is_integer(b_num) and is_integer(b_denom) do
    reduce({a_num * b_denom, a_denom * b_num})
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({a_num, a_denom}) when is_integer(a_num) and is_integer(a_denom) do
    reduce({Kernel.abs(a_num), Kernel.abs(a_denom)})
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({a_num, a_denom}, n)
      when is_integer(a_num) and is_integer(a_denom) and is_integer(n) and n >= 0 do
    num = a_num |> :math.pow(n) |> round()
    denom = a_denom |> :math.pow(n) |> round()
    reduce({num, denom})
  end

  def pow_rational({a_num, a_denom}, n)
      when is_integer(a_num) and is_integer(a_denom) and is_integer(n) and n < 0 do
    m = Kernel.abs(n)
    num = a_num |> :math.pow(m) |> round()
    denom = a_denom |> :math.pow(m) |> round()
    reduce({denom, num})
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: float, n :: rational) :: float
  def pow_real(x, {a_num, a_denom})
      when is_integer(a_num) and is_integer(a_denom) and is_number(x) do
    x
    |> :math.pow(a_num)
    |> :math.pow(1.0 / a_denom)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({0, _}), do: {0, 1}

  def reduce({num, denom}) when denom < 0, do: reduce({-num, -denom})

  def reduce({num, denom}) do
    gcd = Integer.gcd(num, denom)
    {div(num, gcd), div(denom, gcd)}
  end
end
