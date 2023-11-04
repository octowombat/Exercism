defmodule RPNCalculatorInspection do
  @spec start_reliability_check((String.t() -> any()), String.t()) :: %{
          input: String.t(),
          pid: pid()
        }
  def start_reliability_check(calculator, input)
      when is_function(calculator, 1) and is_binary(input) do
    pid = spawn_link(fn -> calculator.(input) end)
    %{input: input, pid: pid}
  end

  @spec await_reliability_check_result(
          %{:input => any(), :pid => any(), optional(any()) => any()},
          map()
        ) :: map()
  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} ->
        add_result(results, input, :ok)

      {:EXIT, ^pid, _reason} ->
        add_result(results, input, :error)
    after
      100 ->
        add_result(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    flag = Process.flag(:trap_exit, true)

    results =
      for input <- inputs do
        start_reliability_check(calculator, input)
      end
      |> reliability_result(%{})

    Process.flag(:trap_exit, flag)
    results
  end

  defp reliability_result([], results), do: results

  defp reliability_result([action | t], results) do
    updated = await_reliability_check_result(action, results)
    reliability_result(t, updated)
  end

  def correctness_check(calculator, inputs) do
    inputs
    |> Enum.map(&Task.async(fn -> calculator.(&1) end))
    |> Enum.map(&Task.await(&1, 100))
  end

  defp add_result(results, input, result), do: Map.put_new(results, input, result)
end
