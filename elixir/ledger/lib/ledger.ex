defmodule Ledger do
  @doc """
  Format the given entries given a currency and locale
  """
  @type currency :: :usd | :eur
  @type locale :: :en_US | :nl_NL
  @type entry :: %{amount_in_cents: integer(), date: Date.t(), description: String.t()}

  @dictionary %{
    change: [en_US: "Change", nl_NL: "Verandering"],
    date: [en_US: "Date", nl_NL: "Datum"],
    description: [en_US: "Description", nl_NL: "Omschrijving"]
  }

  @padding [change: 13, date: 11, description: 26]

  @valid_days Enum.to_list(1..31)
  @valid_months Enum.to_list(1..12)

  @spec format_entries(currency(), locale(), list(entry())) :: String.t()
  def format_entries(_currency, locale, []), do: header(locale)

  def format_entries(currency, locale, entries) do
    sorter = &{&1.date, Date, &1.description, &1.amount_in_cents}

    table =
      entries
      |> Enum.sort_by(sorter)
      |> Enum.map_join("\n", &format_entry(currency, locale, &1))

    header(locale) <> table <> "\n"
  end

  defp header(locale) do
    Enum.map_join(
      [:date, :description, :change],
      "| ",
      &format_spelling(&1, translate(&1, locale))
    ) <>
      "\n"
  end

  defp translate(word, locale), do: @dictionary[word][locale]

  defp format_spelling(word, spelling), do: String.pad_trailing(spelling, @padding[word])

  defp format_entry(currency, locale, entry) do
    date = format_date(entry.date, locale)

    amount = format_amount(entry.amount_in_cents, locale, currency)

    description =
      if entry.description |> String.length() > 26 do
        " " <> String.slice(entry.description, 0, 22) <> "..."
      else
        " " <> String.pad_trailing(entry.description, 25, " ")
      end

    date <> "|" <> description <> " |" <> amount
  end

  defp format_date(%Date{day: day, month: month, year: year}, :en_US) do
    "#{pad_month(month)}/#{pad_day(day)}/#{year} "
  end

  defp format_date(%Date{day: day, month: month, year: year}, :nl_NL) do
    "#{pad_day(day)}-#{pad_month(month)}-#{year} "
  end

  defp pad_day(day) when day in @valid_days,
    do: Integer.to_string(day) |> String.pad_leading(2, "0")

  defp pad_month(month) when month in @valid_months,
    do: Integer.to_string(month) |> String.pad_leading(2, "0")

  defp format_amount(amount_in_cents, locale, currency)
       when is_integer(amount_in_cents) do
    format_money(amount_in_cents, locale, currency) |> String.pad_leading(14, " ")
  end

  defp format_money(amount_in_cents, :en_US = locale, :usd)
       when is_integer(amount_in_cents) and amount_in_cents >= 0 do
    [dollars, cents] = split_amount(amount_in_cents, locale)

    " $#{dollars}.#{String.pad_trailing(cents, 2, "0")} "
  end

  defp format_money(amount_in_cents, :en_US = locale, :usd)
       when is_integer(amount_in_cents) do
    [dollars, cents] = split_amount(-amount_in_cents, locale)

    "($#{dollars}.#{String.pad_trailing(cents, 2, "0")})"
  end

  defp format_money(amount_in_cents, :nl_NL = locale, :eur)
       when is_integer(amount_in_cents) and amount_in_cents >= 0 do
    [euros, cents] = split_amount(amount_in_cents, locale)

    "€ #{euros},#{String.pad_trailing(cents, 2, "0")} "
  end

  defp format_money(amount_in_cents, :nl_NL = locale, :eur)
       when is_integer(amount_in_cents) do
    [euros, cents] = split_amount(-amount_in_cents, locale)

    "€-#{euros},#{String.pad_trailing(cents, 2, "0")} "
  end

  defp format_money(amount_in_cents, :en_US = locale, :eur)
       when is_integer(amount_in_cents) and amount_in_cents >= 0 do
    [euros, cents] = split_amount(amount_in_cents, locale)

    "€ #{euros}.#{String.pad_trailing(cents, 2, "0")}"
  end

  defp format_money(amount_in_cents, :en_US = locale, :eur)
       when is_integer(amount_in_cents) do
    [euros, cents] = split_amount(-amount_in_cents, locale)

    "(€#{euros}.#{String.pad_trailing(cents, 2, "0")})"
  end

  defp format_money(amount_in_cents, :nl_NL = locale, :usd)
       when is_integer(amount_in_cents) and amount_in_cents >= 0 do
    [dollars, cents] = split_amount(amount_in_cents, locale)

    "$ #{dollars},#{String.pad_trailing(cents, 2, "0")} "
  end

  defp format_money(amount_in_cents, :nl_NL = locale, :usd)
       when is_integer(amount_in_cents) do
    [dollars, cents] = split_amount(-amount_in_cents, locale)

    "$ -#{dollars},#{String.pad_trailing(cents, 2, "0")} "
  end

  defp split_amount(amount_in_cents, locale) do
    [first, last] =
      amount_in_cents
      |> Kernel./(100)
      |> to_string()
      |> String.split(".")

    [localise_number(first, locale), last]
  end

  defp localise_number(number_text, locale) do
    bits =
      number_text
      |> String.codepoints()
      |> Enum.reverse()
      |> Enum.chunk_every(3)
      |> Enum.map(&Enum.reverse/1)
      |> Enum.reverse()

    case locale do
      :en_US -> Enum.join(bits, ",")
      :nl_NL -> Enum.join(bits, ".")
    end
  end
end
