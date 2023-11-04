defmodule RPNCalculator do
  def calculate!(stack, operation) when is_list(stack) and is_function(operation, 1) do
    operation.(stack)
  end

  def calculate(stack, operation) do
    try do
      result = operation.(stack)
      {:ok, result}
    rescue
      _any_error ->
        :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      result = operation.(stack)
      {:ok, result}
    rescue
      e ->
        case is_map(e) and Map.has_key?(e, :message) do
          true -> {:error, e.message}
          _ -> :error
        end
    end
  end
end
