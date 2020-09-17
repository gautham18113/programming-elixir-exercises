defmodule Mylist do
  def max([]), do: 0
  def max([a | []]), do: a
  def max([a | [ b | tail]]) when a >= b do
    max([a | tail])
  end
  def max([a | [ b | tail]]) when a < b do
    max([b | tail])
  end
end
