defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) when is_binary(base) and is_list(candidates) do
    l = String.length(base)

    candidates
    |> Enum.reject(&(String.length(&1) != l))
    |> Enum.reject(&(String.downcase(&1) == String.downcase(base)))
    |> Enum.filter(&anagram?(base, &1))
  end

  defp anagram?(base, candidate) do
    letters = String.codepoints(base)

    letters
    |> Enum.reduce(candidate, fn letter, word ->
      pattern = [String.downcase(letter), letter, String.upcase(letter)]
      String.replace(word, pattern, "", global: false)
    end)
    |> String.length()
    |> Kernel.==(0)
  end
end
