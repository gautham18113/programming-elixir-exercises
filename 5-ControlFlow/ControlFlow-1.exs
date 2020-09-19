defmodule FizzBuzz do
  def with_case([a, b, c]) do
    case [a, b, c] do
      [0, 0, _] -> "FizzBuzz"
      [0, _, _] -> "Fizz"
      [_, 0, _] -> "Buzz"
      [_, _, x] -> x
    end
  end
end
