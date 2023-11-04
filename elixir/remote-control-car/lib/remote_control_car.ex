defmodule RemoteControlCar do
  @moduledoc """
  Functions simulating the use of a remote control car.
  """
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  @type t :: %{
          battery_percentage: 0..100,
          distance_driven_in_meters: non_neg_integer(),
          nickname: String.t()
        }

  alias __MODULE__

  @doc "Create a new remote control car."
  @spec new() :: t()
  def new do
    new("none")
  end

  @doc "Create a new remote control car with a nickname."
  @spec new(String.t()) :: t()
  def new(nickname) do
    %RemoteControlCar{nickname: nickname}
  end

  @doc "Display the distance the remote control car has travelled in meters."
  @spec display_distance(t()) :: String.t()
  def display_distance(%RemoteControlCar{} = remote_car) do
    %RemoteControlCar{distance_driven_in_meters: d} = remote_car
    "#{d} meters"
  end

  @doc "Display the remaining battery charge of the remote control car as a %."
  @spec display_battery(t()) :: String.t()
  def display_battery(%RemoteControlCar{} = remote_car) do
    %RemoteControlCar{battery_percentage: b} = remote_car
    if b == 0, do: "Battery empty", else: "Battery at #{b}%"
  end

  @doc """
  Drive the remote control car. Each 'drive' takes the car 20 meters
  and drains 1% of the battery power. If the battery is already at 0%
  then the car will not move.
  """
  @spec drive(t()) :: t()
  def drive(%RemoteControlCar{battery_percentage: 0} = remote_car), do: remote_car

  def drive(%RemoteControlCar{} = remote_car) do
    %RemoteControlCar{battery_percentage: b, distance_driven_in_meters: d} = remote_car
    %RemoteControlCar{remote_car | battery_percentage: b - 1, distance_driven_in_meters: d + 20}
  end
end
