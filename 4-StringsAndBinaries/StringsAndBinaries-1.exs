defmodule PrintableAscii do
  def check(list) do
    list
    |> Enum.map(fn (x) -> x >= ?\s and x<= ?~ end)
    |> Enum.all?()
  end
end
