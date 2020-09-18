defmodule Anagram do
  def anagram?(s1, s2) do
    checkanag(s1 -- s2) and checkanag(s2 -- s1)
  end

  defp checkanag([]), do: true

  defp checkanag(_), do: false

end
