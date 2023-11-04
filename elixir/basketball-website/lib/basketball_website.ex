defmodule BasketballWebsite do
  def extract_from_path(data, "") when is_map(data), do: nil

  def extract_from_path(data, path) when is_map(data) and is_binary(path) do
    path
    |> String.split(".")
    |> Enum.reduce(data, & &2[&1])
  end

  def get_in_path(data, path) when is_map(data) and is_binary(path) do
    get_in(data, String.split(path, "."))
  end
end
