defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) when number < 0, do: false
  def valid?(number) when number in 0..9, do: true
  def valid?(number) when number in 10..19, do: false

  def valid?(number) do
    digits = Integer.digits(number) |> dbg()
    power = length(digits) |> dbg()

    Enum.reduce(digits, 0, fn digit, sum ->
      Integer.pow(digit, power) + sum
    end) == number
  end
end
