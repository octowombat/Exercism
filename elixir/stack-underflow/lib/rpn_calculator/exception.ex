defmodule RPNCalculator.Exception do
  # Please implement DivisionByZeroError here.
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  # Please implement StackUnderflowError here.
  defmodule StackUnderflowError do
    alias __MODULE__

    @default_message "stack underflow occurred"

    defexception message: @default_message

    @impl Exception
    def exception(value) do
      case value do
        [] ->
          %StackUnderflowError{}

        _ ->
          %StackUnderflowError{message: @default_message <> ", context: #{value}"}
      end
    end
  end

  @underflow_context "when dividing"

  @spec divide(list(non_neg_integer())) :: number() | no_return()
  def divide([]), do: raise(StackUnderflowError, @underflow_context)
  def divide([_single]), do: raise(StackUnderflowError, @underflow_context)
  def divide([0, _numerator]), do: raise(DivisionByZeroError)

  def divide([denominator, numerator])
      when is_integer(numerator) and numerator >= 0 and is_integer(denominator) and
             denominator > 0 do
    numerator / denominator
  end
end
