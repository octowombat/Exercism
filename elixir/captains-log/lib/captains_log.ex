defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  @spec random_planet_class() :: String.t()
  def random_planet_class do
    Enum.random(@planetary_classes)
  end

  @spec random_ship_registry_number() :: String.t()
  def random_ship_registry_number do
    "NCC-#{Enum.random(1000..9999)}"
  end

  @spec random_stardate() :: float()
  def random_stardate do
    41_000 + :rand.uniform() * 1_000
  end

  @spec format_stardate(float()) :: String.t()
  def format_stardate(stardate) do
    :io_lib.format("~.1f", [stardate]) |> to_string()
  end
end
