defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @suffix "ay"
  @vowels ~c"aeiou"

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    String.split(phrase, " ")
    |> Enum.map_join(" ", &translate_word/1)
  end

  defp translate_word(<<letter::utf8, _rest::binary>> = phrase) when letter in @vowels do
    phrase <> @suffix
  end

  defp translate_word(<<?x, letter::utf8, _rest::binary>> = phrase) when letter in [?r, ?t] do
    phrase <> @suffix
  end

  defp translate_word(<<character::utf8, letter::utf8, _rest::binary>> = phrase)
       when character in [?x, ?y] and letter not in @vowels do
    phrase <> @suffix
  end

  defp translate_word(<<letter::utf8, ?q, ?u, rest::binary>>) when letter not in @vowels do
    rest <> <<letter, ?q, ?u>> <> @suffix
  end

  defp translate_word(<<?q, ?u, rest::binary>>), do: rest <> <<?q, ?u>> <> @suffix

  defp translate_word(<<letter::utf8, ?y::utf8>>), do: <<?y, letter>> <> @suffix

  defp translate_word(phrase) when is_binary(phrase) do
    {front, rear, _} =
      for <<letter::utf8 <- phrase>>, reduce: {"", "", :unknown} do
        {f, r, :unknown} when letter not in @vowels ->
          {f, r <> <<letter>>, :consonant}

        {f, r, :consonant} when letter == ?y ->
          {<<letter>> <> f, r, :vowel}

        {f, r, :consonant} when letter in @vowels ->
          {<<letter>> <> f, r, :vowel}

        {f, r, :consonant} when letter not in @vowels ->
          {f, r <> <<letter>>, :consonant}

        {f, r, :vowel} ->
          {f <> <<letter>>, r, :vowel}
      end

    front <> rear <> @suffix
  end
end
