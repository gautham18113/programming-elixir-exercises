defmodule Taxes do
  def apply(orders, tax) do
    for x <- orders, do: Keyword.put(x, :total_amount, x[:net_amount] + (x[:net_amount]*Keyword.get(tax, x[:ship_to], 0)))
  end
end
