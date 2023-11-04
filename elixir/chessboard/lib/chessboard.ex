defmodule Chessboard do
  @spec rank_range() :: Range.t()
  def rank_range do
    1..8
  end

  @spec file_range() :: Range.t()
  def file_range do
    ?A..?H
  end

  @spec ranks() :: list(non_neg_integer())
  def ranks do
    Enum.to_list(rank_range())
  end

  @spec files() :: list(String.t())
  def files do
    Enum.map(file_range(), &<<&1>>)
  end
end
