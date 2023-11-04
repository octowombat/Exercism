defmodule LogParser do
  def valid_line?(line) when is_binary(line) do
    line =~ ~r/^\[DEBUG\]|^\[ERROR\]|^\[INFO\]|^\[WARNING\][\w\s]+/
  end

  def split_line(line) do
    String.split(line, ~r/\<[~*=-]*\>/)
  end

  def remove_artifacts(line) do
    String.replace(line, ~r/end-of-line\d{1,5}/i, "")
  end

  def tag_with_user_name(line) do
    user = Regex.run(~r/User\s+([\S]+)/u, line)

    case user do
      nil ->
        line

      [_, u] ->
        "[USER] #{u} " <> line
    end
  end
end
