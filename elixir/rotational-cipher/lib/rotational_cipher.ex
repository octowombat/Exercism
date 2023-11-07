defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) when is_binary(text) and shift in 0..26 do
    for <<c::8 <- text>>, reduce: <<>> do
      acc when c in ?a..?z ->
        acc <> <<Integer.mod(c - ?a + shift, 26) + ?a>>

      acc when c in ?A..?Z ->
        acc <> <<Integer.mod(c - ?A + shift, 26) + ?A>>

      acc ->
        acc <> <<c::8>>
    end
  end
end
