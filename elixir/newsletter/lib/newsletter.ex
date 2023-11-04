defmodule Newsletter do
  @spec read_emails(binary()) :: [String.t()]
  def read_emails(path) when is_binary(path) do
    path
    |> File.read!()
    |> String.split()
  end

  @spec open_log(binary()) :: pid()
  def open_log(path) when is_binary(path) do
    File.open!(path, [:write])
  end

  @spec log_sent_email(pid(), String.t()) :: :ok
  def log_sent_email(pid, email) when is_pid(pid) and is_binary(email) do
    IO.puts(pid, email)
  end

  @spec close_log(pid()) :: :ok
  def close_log(pid) when is_pid(pid) do
    File.close(pid)
  end

  @spec send_newsletter(binary(), binary(), function()) :: :ok
  def send_newsletter(emails_path, log_path, send_fun)
      when is_binary(emails_path) and is_binary(log_path) and is_function(send_fun, 1) do
    log = open_log(log_path)

    emails_path
    |> read_emails()
    |> Enum.each(&sender(&1, send_fun, log))

    close_log(log)
  end

  defp sender(email, send_fun, log) do
    case send_fun.(email) do
      :ok -> log_sent_email(log, email)
      :error -> :noop
    end
  end
end
