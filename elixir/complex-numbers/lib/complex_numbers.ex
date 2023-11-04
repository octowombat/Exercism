defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {float, float}

  @doc """
  Return the real part of a complex number
  """
  @spec real(z :: complex) :: float
  def real({a, _b}) when is_number(a), do: a

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(z :: complex) :: float
  def imaginary({_a, b}) when is_number(b), do: b

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(z :: complex | float, w :: complex | float) :: complex
  def mul({a, b} = z, w) when is_number(a) and is_number(b) and is_number(w), do: mul(z, {w, 0.0})
  def mul(z, {c, d} = w) when is_number(c) and is_number(d) and is_number(z), do: mul({z, 0.0}, w)

  def mul({a, b}, {c, d}) when is_number(a) and is_number(b) and is_number(c) and is_number(d) do
    {a * c - b * d, b * c + a * d}
  end

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(z :: complex | float, w :: complex | float) :: complex
  def add({a, b} = z, w) when is_number(a) and is_number(b) and is_number(w), do: add(z, {w, 0.0})
  def add(z, {c, d} = w) when is_number(c) and is_number(d) and is_number(z), do: add({z, 0.0}, w)

  def add({a, b}, {c, d}) when is_number(a) and is_number(b) and is_number(c) and is_number(d) do
    {a + c, b + d}
  end

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(z :: complex | float, w :: complex | float) :: complex
  def sub({a, b} = z, w) when is_number(a) and is_number(b) and is_number(w), do: sub(z, {w, 0.0})
  def sub(z, {c, d} = w) when is_number(c) and is_number(d) and is_number(z), do: sub({z, 0.0}, w)

  def sub({a, b}, {c, d}) when is_number(a) and is_number(b) and is_number(c) and is_number(d) do
    {a - c, b - d}
  end

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(z :: complex | float, w :: complex | float) :: complex
  def div({a, b} = z, w) when is_number(a) and is_number(b) and is_number(w),
    do: ComplexNumbers.div(z, {w, 0.0})

  def div(z, {c, d} = w) when is_number(c) and is_number(d) and is_number(z),
    do: ComplexNumbers.div({z, 0.0}, w)

  def div({a, b}, {c, d})
      when is_number(a) and is_number(b) and is_number(c) and is_number(d) do
    denom = c * c + d * d
    {(a * c + b * d) / denom, (b * c - a * d) / denom}
  end

  @doc """
  Absolute value of a complex number
  """
  @spec abs(z :: complex) :: float
  def abs(z) do
    z
    |> conjugate()
    |> mul(z)
    |> real()
    |> :math.sqrt()
  end

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(z :: complex) :: complex
  def conjugate({a, b}) when is_number(a) and is_number(b) do
    {a, -b}
  end

  @doc """
  Exponential of a complex number
  """
  @spec exp(z :: complex) :: complex
  def exp({a, b}) when is_number(a) and is_number(b) do
    e = :math.exp(1)
    r = :math.pow(e, a)
    mul({r, 0.0}, {:math.cos(b), :math.sin(b)})
  end
end
