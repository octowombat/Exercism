defmodule Bob do
  @moduledoc """
  Bob the lackadaisical teenager's conversational prowess.
  """
  @spec hey(String.t()) :: String.t()
  def hey(request) do
    cond do
      request == "" ->
        "Fine. Be that way!"

      String.trim(request) == "" ->
        "Fine. Be that way!"

      request == String.upcase(request) and String.match?(request, ~r/[a-zA-Z]/) and
          String.ends_with?(request, "?") ->
        "Calm down, I know what I'm doing!"

      String.trim(request) |> String.ends_with?("?") ->
        "Sure."

      request == String.upcase(request) and String.match?(request, ~r/[^\W\,\d]/) ->
        "Whoa, chill out!"

      true ->
        "Whatever."
    end
  end
end
