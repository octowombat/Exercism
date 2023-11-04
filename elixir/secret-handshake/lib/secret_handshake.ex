defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @reverse_code 16
  @actions %{
    1 => "wink",
    2 => "double blink",
    4 => "close your eyes",
    8 => "jump"
  }
  @action_codes [1, 2, 4, 8, @reverse_code]

  @spec commands(code :: integer) :: list(String.t())
  def commands(@reverse_code), do: []

  def commands(code) when code in @action_codes, do: [@actions[code]]

  def commands(code) when code in 1..31 do
    get_actions(code)
  end

  def commands(code) when is_integer(code), do: []

  defp get_actions(code) do
    get_action(@action_codes, code, [])
  end

  defp get_action([], _code, actions), do: actions

  defp get_action([action | t], code, actions) do
    acc =
      case Bitwise.&&&(code, action) do
        0 ->
          actions

        _factor ->
          case action do
            @reverse_code -> Enum.reverse(actions)
            _other -> actions ++ [@actions[action]]
          end
      end

    get_action(t, code, acc)
  end
end
