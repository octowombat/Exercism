defmodule Darts do
  @type position :: {number, number}

  @outer_ring 10
  @inner_ring 1
  @middle 5
  @outer_score 1
  @inner_score 10
  @no_score 0
  @o2 100
  @m2 25
  @i2 1

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, _}) when abs(x) > @outer_ring, do: @no_score
  def score({_, y}) when abs(y) > @outer_ring, do: @no_score
  def score({0, y}) when abs(y) == @outer_ring, do: @outer_score
  def score({x, 0}) when abs(x) == @outer_ring, do: @outer_score
  def score({0, y}) when abs(y) == @middle, do: @middle
  def score({x, 0}) when abs(x) == @middle, do: @middle
  def score({0, y}) when abs(y) == @inner_ring, do: @inner_score
  def score({x, 0}) when abs(x) == @inner_ring, do: @inner_score

  def score({x, y}) do
    r2 = x * x + y * y

    cond do
      r2 > @o2 ->
        @no_score

      r2 > @m2 and r2 < @o2 ->
        @outer_score

      r2 > @i2 and r2 < @m2 ->
        @middle

      true ->
        @inner_score
    end
  end
end
