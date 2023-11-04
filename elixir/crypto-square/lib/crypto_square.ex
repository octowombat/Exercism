defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""

  def encode(str) when is_binary(str) do
    str |> normalise() |> rectangle() |> transpose()
  end

  defp normalise(str) do
    str |> String.replace(~r/[^\w]*/, "") |> String.downcase()
  end

  defp rectangle(""), do: ""

  defp rectangle(str) do
    l = String.length(str)
    upper = ceil(:math.sqrt(l))

    {r, c} =
      for(r <- 1..upper, c <- 1..upper, r * c >= l, c >= r, c - r <= 1, do: {r, c})
      |> Enum.min_by(&elem(&1, 0))

    {
      r,
      c,
      str
      |> String.pad_trailing(r * c)
      |> String.splitter("", trim: true)
      |> Enum.chunk_every(c)
    }
  end

  defp transpose(""), do: ""

  defp transpose({r, c, grid}) do
    for(col <- 0..(c - 1), row <- 0..(r - 1), do: at(grid, row, col))
    |> Enum.chunk_every(r)
    |> Enum.map_join(" ", &Enum.join/1)
  end

  defp at(grid, row, col) do
    grid |> Enum.at(row) |> Enum.at(col)
  end
end
