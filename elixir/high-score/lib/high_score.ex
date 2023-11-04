defmodule HighScore do
  def new do
    %{}
  end

  def add_player(scores, name, score \\ 0)
      when is_map(scores) and is_binary(name) and is_integer(score) and score >= 0 do
    Map.put(scores, name, score)
  end

  def remove_player(scores, name) when is_map(scores) and is_binary(name) do
    Map.delete(scores, name)
  end

  def reset_score(scores, name) when is_map(scores) and is_binary(name) do
    Map.put(scores, name, 0)
  end

  def update_score(scores, name, score)
      when is_map(scores) and is_binary(name) and is_integer(score) and score >= 0 do
    Map.update(scores, name, score, &(&1 + score))
  end

  def get_players(scores) when is_map(scores) do
    Map.keys(scores)
  end
end
