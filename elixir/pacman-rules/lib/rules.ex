defmodule Rules do
  def eat_ghost?(power_pellet_active, touching_ghost)
      when is_boolean(power_pellet_active) and is_boolean(touching_ghost) do
    power_pellet_active and touching_ghost
  end

  def score?(touching_power_pellet, touching_dot)
      when is_boolean(touching_power_pellet) and is_boolean(touching_dot) do
    touching_power_pellet or touching_dot
  end

  def lose?(power_pellet_active, touching_ghost)
      when is_boolean(power_pellet_active) and is_boolean(touching_ghost) do
    not power_pellet_active and touching_ghost
  end

  def win?(has_eaten_all_dots, power_pellet_active, touching_ghost)
      when is_boolean(has_eaten_all_dots) and is_boolean(power_pellet_active) and
             is_boolean(touching_ghost) do
    has_eaten_all_dots and not lose?(power_pellet_active, touching_ghost)
  end
end
