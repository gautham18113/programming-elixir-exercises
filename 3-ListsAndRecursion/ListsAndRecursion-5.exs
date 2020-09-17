defmodule MyEnum do
  def all?([], _), do: true
  def all?([head | tail], func) do
    if func.(head) do
      all?(tail, func)
    else
      false
    end
  end

  def each([], _), do: :ok
  def each([head| tail], func) do
    func.(head)
    each(tail, func)
  end

  def filter([],_), do: []
  def filter([head | tail], func) do
    if func.(head) do
      [head | filter(tail,func)]
    else
      filter(tail, func)
    end
  end

  def split(list, count), do: _split(list, [], count)
  defp _split([], [], _), do: {[], []}
  defp _split(tail, splitted, 0), do: {splitted, tail}
  defp _split([head | tail], splitted, count) do
    _split(tail, splitted ++ [head], count-1)
  end

  def take(list, count) do
    {f, b} = split(list, count)
    f
  end

end
