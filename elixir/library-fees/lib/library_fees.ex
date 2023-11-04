defmodule LibraryFees do
  @noon ~T[12:00:00]
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    datetime
    |> NaiveDateTime.to_time()
    |> Time.compare(@noon) == :lt
  end

  def return_date(checkout_datetime) do
    days = fn dt ->
      if before_noon?(dt), do: 28, else: 29
    end

    checkout_datetime
    |> NaiveDateTime.to_date()
    |> Date.add(days.(checkout_datetime))
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime
    |> NaiveDateTime.to_date()
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week()
    |> Kernel.==(1)
  end

  def calculate_late_fee(checkout, return, rate) do
    return_date = datetime_from_string(return)

    checkout
    |> datetime_from_string()
    |> return_date()
    |> days_late(return_date)
    |> Kernel.*(rate)
    |> fee(return_date)
  end

  defp fee(f, d) do
    if monday?(d), do: div(f, 2), else: f
  end
end
