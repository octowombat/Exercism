defmodule LogLevel do
  @supported_legacy_log_codes [1..4]
  @unknown_label :unknown
  @unsupported_legacy_log_codes [0, 5]
  @valid_log_codes 0..5

  def to_label(log_code, _) when is_integer(log_code) and log_code not in @valid_log_codes,
    do: @unknown_label

  def to_label(log_code, true)
      when is_integer(log_code) and log_code in @unsupported_legacy_log_codes,
      do: @unknown_label

  def to_label(log_code, true)
      when is_integer(log_code) and log_code in @supported_legacy_log_codes,
      do: label(log_code)

  def to_label(log_code, _) when is_integer(log_code) and log_code in @valid_log_codes,
    do: label(log_code)

  def alert_recipient(log_code, legacy?) when is_integer(log_code) and is_boolean(legacy?) do
    log_code
    |> to_label(legacy?)
    |> recipient(legacy?)
  end

  defp label(0), do: :trace
  defp label(1), do: :debug
  defp label(2), do: :info
  defp label(3), do: :warning
  defp label(4), do: :error
  defp label(5), do: :fatal
  defp label(_), do: @unknown_label

  defp recipient(@unknown_label, true), do: :dev1
  defp recipient(@unknown_label, _), do: :dev2
  defp recipient(log_level, _) when log_level in [:error, :fatal], do: :ops
  defp recipient(_, _), do: false
end
