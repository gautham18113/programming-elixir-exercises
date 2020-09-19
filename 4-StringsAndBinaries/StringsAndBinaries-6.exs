defmodule MySentence do

  def capitalize(s) do
    s
    |> String.split(~r{\.\s})
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(". ")
  end

end
