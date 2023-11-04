defmodule RPG.CharacterSheet do
  @moduledoc """
  Interacting with players and their characters in a RPG.
  """
  @welcome_message "Welcome! Let's fill out your character sheet together."
  @question "What is your character's"

  @doc """
  Print a welcome message for a player.
  """
  @spec welcome() :: :ok
  def welcome do
    IO.puts(@welcome_message)
  end

  @spec ask_name() :: String.t()
  def ask_name do
    "name"
    |> ask_question()
    |> IO.gets()
    |> String.trim()
  end

  @spec ask_class() :: String.t()
  def ask_class do
    "class"
    |> ask_question()
    |> IO.gets()
    |> String.trim()
  end

  @spec ask_level() :: Integer.t()
  def ask_level do
    "level"
    |> ask_question()
    |> IO.gets()
    |> String.trim()
    |> String.to_integer()
  end

  @spec run() :: map()
  def run do
    welcome()
    name = ask_name()
    class = ask_class()
    level = ask_level()

    IO.inspect(
      %{
        class: class,
        level: level,
        name: name
      },
      label: "Your character"
    )
  end

  defp ask_question(what) do
    "#{@question} #{what}?\n"
  end
end
