defmodule Mylist do
  def span(from, to) when from > to, do: []
  def span(from, to) do
    [from | span(from + 1, to)]
  end

  def get_primes(n) do
    for x <- span(2, n), is_prime(x), do: x
  end

  defp is_prime(n) when n <=1, do: false

  defp is_prime(n) do
    not Enum.any?(for x <- span(2, n-1), do: rem(n, x) == 0)
  end
end
