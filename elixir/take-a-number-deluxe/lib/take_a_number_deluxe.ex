defmodule TakeANumberDeluxe do
  use GenServer

  alias TakeANumberDeluxe.State
  alias __MODULE__

  # Client API

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_args) when is_list(init_args) do
    GenServer.start_link(TakeANumberDeluxe, init_args, [])
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) when is_pid(machine) do
    GenServer.call(machine, :report_state)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) when is_pid(machine) do
    GenServer.call(machine, :queue_new_number)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) when is_pid(machine) do
    GenServer.call(machine, {:next_queued_number, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) when is_pid(machine) do
    GenServer.cast(machine, :reset)
  end

  # Server callbacks
  @impl GenServer
  def init(init_arg) do
    max_number = Keyword.get(init_arg, :max_number)
    min_number = Keyword.get(init_arg, :min_number)
    timeout = Keyword.get(init_arg, :auto_shutdown_timeout, :infinity)

    case State.new(min_number, max_number, timeout) do
      {:ok, %State{} = state} ->
        {:ok, state, state.auto_shutdown_timeout}

      {:error, reason} ->
        {:stop, reason}
    end
  end

  @impl GenServer
  def handle_call(:report_state, _from, %State{} = state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  def handle_call(:queue_new_number, _from, %State{} = state) do
    case State.queue_new_number(state) do
      {:ok, number, %State{} = new_state} ->
        {:reply, {:ok, number}, new_state, new_state.auto_shutdown_timeout}

      {:error, _reason} = err ->
        {:reply, err, state, state.auto_shutdown_timeout}
    end
  end

  def handle_call({:next_queued_number, priority}, _from, %State{} = state) do
    case State.serve_next_queued_number(state, priority) do
      {:ok, number, %State{} = new_state} ->
        {:reply, {:ok, number}, new_state, new_state.auto_shutdown_timeout}

      {:error, _reason} = err ->
        {:reply, err, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset, %State{} = state) do
    %State{auto_shutdown_timeout: timeout, max_number: max_num, min_number: min_num} = state

    case State.new(min_num, max_num, timeout) do
      {:ok, %State{} = reset} ->
        {:noreply, reset, reset.auto_shutdown_timeout}

      {:error, _reason} ->
        {:noreply, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_info(:timeout, %State{} = state) do
    {:stop, :normal, state}
  end

  def handle_info(_msg, %State{} = state) do
    {:noreply, state, state.auto_shutdown_timeout}
  end
end
