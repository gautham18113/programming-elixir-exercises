defmodule Mylist do
  def flatten(list), do: do_flat(list, [])

  defp do_flat([], flat), do: flat
  defp do_flat([h | t], flat) when is_list(h) do
    do_flat(h, flat)
  end
  defp do_flat([h|t], flat) do
    do_flat(t, flat ++ [h])
  end
end
