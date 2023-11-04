defmodule GuessingGame do
  @close "So close"
  @correct "Correct"
  @high "Too high"
  @low "Too low"
  @no_guess "Make a guess"

  def compare(secret_number, guess \\ :no_guess)
  def compare(_, :no_guess), do: @no_guess
  def compare(x, x) when is_integer(x), do: @correct

  def compare(secret_number, guess)
      when is_integer(secret_number) and is_integer(guess) and abs(guess - secret_number) == 1,
      do: @close

  def compare(secret_number, guess)
      when is_integer(secret_number) and is_integer(guess) and guess > secret_number,
      do: @high

  def compare(secret_number, guess)
      when is_integer(secret_number) and is_integer(guess) and guess < secret_number,
      do: @low
end
