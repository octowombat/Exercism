defmodule ResistorColorTrio do
  @bands [
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  ]

  @doc """
  Calculate the resistance value in ohm or kiloohm from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms}
  def label(colors) do
    [first, second, third] = colors
    v = (@bands[first] * 10 + @bands[second]) * Integer.pow(10, @bands[third])

    if v > 1000 do
      {div(v, 1000), :kiloohms}
    else
      {v, :ohms}
    end
  end
end
