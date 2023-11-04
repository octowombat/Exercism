defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @gigaseconds 1_000_000_000

  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    %DateTime{year: y, month: m, day: d, hour: h, minute: mins, second: s} =
      DateTime.new!(Date.new!(year, month, day), Time.new!(hours, minutes, seconds))
      |> DateTime.add(@gigaseconds)

    {{y, m, d}, {h, mins, s}}
  end
end
