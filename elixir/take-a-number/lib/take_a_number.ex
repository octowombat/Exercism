defmodule TakeANumber do
  @initial_state 0

  @spec start() :: pid()
  def start do
    spawn(fn -> server(@initial_state) end)
  end

  defp server(state) when is_integer(state) and state >= 0 do
    updated_state =
      receive do
        {:report_state, client} ->
          send(client, state)

        {:take_a_number, client} ->
          send(client, state + 1)

        :stop ->
          :exit

        _ ->
          state
      end

    unless updated_state == :exit, do: server(updated_state)
  end
end
