defmodule Guess do
  def me(n, a.._) when a==n do
    a
  end
  def me(n, _..b) when b==n do
    b
  end
  def me(n, a..b) when trunc((a+b)/2) <= n do
    IO.puts "Is it #{trunc((a+b)/2)}"
    me(n, trunc((a+b)/2)..b)
  end
  def me(n, a..b) when trunc((a+b)/2) > n do
    IO.puts "Is it #{trunc((a+b)/2)}"
    me(n, a..trunc((a+b)/2))
  end
end
