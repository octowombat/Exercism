defmodule ETL do
  @doc """
  Transforms an old Scrabble score system to a new one.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}
  """
  @spec transform(map) :: map
  def transform(input) when is_map(input) do
    for {score, letters} <- input, letter <- letters, tile = String.downcase(letter), into: %{} do
      {tile, score}
    end
  end
end
