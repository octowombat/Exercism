defmodule Username do
  @spec sanitize(charlist()) :: charlist()
  def sanitize(username) when is_list(username) do
    # ä becomes ae
    # ö becomes oe
    # ü becomes ue
    # ß becomes ss
    strip_non_lowercase(username, [])
  end

  defp strip_non_lowercase([], username), do: Enum.reverse(username)

  defp strip_non_lowercase([letter | remainder], username) do
    cond do
      letter >= ?a and letter <= ?z ->
        strip_non_lowercase(remainder, [letter | username])

      letter == ?_ ->
        strip_non_lowercase(remainder, [letter | username])

      letter in [?ä, ?ö, ?ü, ?ß] ->
        [f, s] = substitute(letter)
        strip_non_lowercase(remainder, [s, f | username])

      true ->
        strip_non_lowercase(remainder, username)
    end
  end

  defp substitute(?ä), do: 'ae'
  defp substitute(?ö), do: 'oe'
  defp substitute(?ü), do: 'ue'
  defp substitute(?ß), do: 'ss'
end
