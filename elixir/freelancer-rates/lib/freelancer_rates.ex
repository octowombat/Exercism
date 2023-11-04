defmodule FreelancerRates do
  @hours_per_day 8
  @days_per_month 22

  def daily_rate(0), do: 0.0
  def daily_rate(0.0), do: 0.0

  def daily_rate(hourly_rate) when is_number(hourly_rate) and hourly_rate > 0 do
    hourly_rate * @hours_per_day / 1.0
  end

  def apply_discount(before_discount, 0), do: before_discount
  def apply_discount(before_discount, 0.0), do: before_discount

  def apply_discount(before_discount, discount)
      when is_number(before_discount) and is_number(discount) and discount >= 0.0 and
             discount <= 100.0 do
    before_discount * (1.0 - discount / 100.0)
  end

  def monthly_rate(0, _), do: 0
  def monthly_rate(0.0, _), do: 0

  def monthly_rate(hourly_rate, discount) when is_number(hourly_rate) and is_number(discount) do
    hourly_rate
    |> daily_rate()
    |> Kernel.*(@days_per_month)
    |> apply_discount(discount)
    |> ceil()
  end

  def days_in_budget(_, 0, _), do: :infinite
  def days_in_budget(0, _, _), do: 0.0

  def days_in_budget(budget, hourly_rate, discount)
      when is_number(budget) and hourly_rate > 0 and is_number(discount) do
    Float.floor(@days_per_month * budget / monthly_rate(hourly_rate, discount), 1)
  end
end
