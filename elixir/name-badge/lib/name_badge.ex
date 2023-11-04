defmodule NameBadge do
  @moduledoc """
  Printing badges for employees.
  """

  @doc "Print a name badge for an employee within a specific department."
  @spec print(id :: non_neg_integer() | nil, name :: String.t(), department :: String.t() | nil) ::
          String.t()

  def print(id, name, department) do
    dept = if is_nil(department), do: "owner", else: department
    identifier = if is_nil(id), do: "", else: "[#{id}] - "
    "#{identifier}#{name} - #{String.upcase(dept)}"
  end
end
