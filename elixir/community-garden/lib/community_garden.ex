# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> {0, []} end, opts)
  end

  def list_registrations(pid) when is_pid(pid) do
    Agent.get(pid, fn state ->
      {_, registrations} = state
      registrations
    end)
  end

  def register(pid, register_to) when is_pid(pid) and is_binary(register_to) do
    Agent.get_and_update(pid, fn state ->
      {count, registrations} = state
      next_id = count + 1
      new_registration = %Plot{plot_id: next_id, registered_to: register_to}
      {new_registration, {next_id, [new_registration | registrations]}}
    end)
  end

  def release(pid, plot_id) when is_pid(pid) and is_integer(plot_id) and plot_id > 0 do
    Agent.update(pid, fn state ->
      {count, registrations} = state
      {count, Enum.reject(registrations, &(&1.plot_id == plot_id))}
    end)
  end

  def get_registration(pid, plot_id) when is_pid(pid) and is_integer(plot_id) and plot_id > 0 do
    Agent.get(pid, fn state ->
      {_, registrations} = state
      Enum.find(registrations, {:not_found, "plot is unregistered"}, &(&1.plot_id == plot_id))
    end)
  end
end
