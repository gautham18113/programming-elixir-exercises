defmodule Taxes do
  def apply(orders, tax) do
    for x <- orders, do: Keyword.put(x, :total_amount, x[:net_amount] + (x[:net_amount]*Keyword.get(tax, x[:ship_to], 0)))
  end
end

defmodule MyFile do
  import Taxes
  def parse(path, tax_rates) do
    File.read!(path)
    |> String.split(~r{[\n]})
    |> Enum.map(&String.split(&1, ","))
    |> map_header()
    |> Enum.map(&transform/1)
    |> Taxes.apply(tax_rates)
  end

  defp transform(order) do
    IO.inspect order
    a = String.to_integer(Keyword.get(order,:id))
    b = String.to_atom(String.replace(Keyword.get(order,:ship_to), ":", ""))
    c = String.to_float(Keyword.get(order,:net_amount))
    [id: a, ship_to: b, net_amount: c]
  end

  defp map_header([h | t]) do
    headers = Enum.map(h, &String.to_atom/1)
    res = Enum.map(t, &Enum.zip(headers, &1))
    IO.inspect res
    res
  end
end
