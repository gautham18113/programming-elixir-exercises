defmodule Print do
  def as_column(strs) do
    strs
      |> String.split()
      |> add_spaces()
      |> Enum.each(&IO.puts/1)
  end

  defp max_word_len([], len), do: len
  defp max_word_len([h|t], len), do: max_word_len(t, max(String.length(h), len))

  defp add_spaces(list) do
    max_len = max_word_len(list, 0)
    _add_space(list, max_len)
  end

  defp _add_space([], _), do: []
  defp _add_space([s|t], max_len) do
    strlen = String.length(s)
    diff = max_len - strlen
    res = String.pad_leading(s, strlen + div(diff, 2))
    [res | _add_space(t, max_len)]
  end

end
