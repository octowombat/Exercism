defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) when is_binary(string) do
    string
    |> String.replace(~r/[.,'_]/, "")
    |> String.split(~r/[\s-]/)
    |> Enum.map_join(fn text ->
      text |> String.upcase() |> String.at(0)
    end)
  end
end
