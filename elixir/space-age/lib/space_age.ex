defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @periods [
    mercury: 0.2408467,
    venus: 0.61519726,
    mars: 1.8808158,
    jupiter: 11.862615,
    saturn: 29.447498,
    uranus: 84.016846,
    neptune: 164.79132
  ]

  @earth_seconds_per_year 31_557_600

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet', or an error if 'planet' is not a planet.
  """
  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(:earth, seconds) when is_integer(seconds) and seconds >= 0,
    do: {:ok, seconds / @earth_seconds_per_year}

  def age_on(planet, seconds) when is_atom(planet) and is_integer(seconds) and seconds >= 0 do
    if Keyword.has_key?(@periods, planet) do
      period = @periods[planet]
      {:ok, seconds / (period * @earth_seconds_per_year)}
    else
      {:error, "not a planet"}
    end
  end
end
