defmodule FileSniffer do
  @file_details %{
    "exe" => "application/octet-stream",
    "bmp" => "image/bmp",
    "png" => "image/png",
    "jpg" => "image/jpg",
    "gif" => "image/gif"
  }

  @extensions Map.keys(@file_details)

  @spec type_from_extension(String.t()) :: String.t()
  def type_from_extension(extension) when extension in @extensions, do: @file_details[extension]

  @spec type_from_binary(binary()) :: String.t()
  def type_from_binary(<<0x7F, 0x45, 0x4C, 0x46, _::binary>>), do: "application/octet-stream"
  def type_from_binary(<<0x42, 0x4D, _::binary>>), do: "image/bmp"

  def type_from_binary(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>>),
    do: "image/png"

  def type_from_binary(<<0xFF, 0xD8, 0xFF, _::binary>>), do: "image/jpg"
  def type_from_binary(<<0x47, 0x49, 0x46, _::binary>>), do: "image/gif"

  @spec verify(binary(), String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def verify(file_binary, extension) do
    file_binary
    |> type_from_binary()
    |> do_verify?(extension)
  end

  defp do_verify?(media_type, extension) do
    if media_type == type_from_extension(extension) do
      {:ok, media_type}
    else
      {:error, "Warning, file format and file extension do not match."}
    end
  end
end
