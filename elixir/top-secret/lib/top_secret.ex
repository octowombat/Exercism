defmodule TopSecret do
  @spec to_ast(binary()) :: tuple()
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  @spec decode_secret_message_part(tuple(), list(binary())) :: tuple()
  def decode_secret_message_part({operation, _metadata, args} = ast, acc)
      when operation in ~w(def defp)a and is_list(args) do
    {fun, fun_args} = decode(args)
    n = length(fun_args)
    decoded = fun |> to_string() |> String.slice(0, n)

    {ast, [decoded | acc]}
  end

  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end

  defp decode([{:when, _when_metadata, when_args} | _rest]) when is_list(when_args) do
    decode(when_args)
  end

  defp decode([{op, _op_metadata, op_args} | _rest]) when is_list(op_args) do
    {op, op_args}
  end

  defp decode([{op, _op_metadata, _op_args} | _rest]) do
    {op, []}
  end

  def decode_secret_message(string) do
    string
    |> to_ast()
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> elem(1)
    |> Enum.reverse()
    |> Enum.join()
  end
end
