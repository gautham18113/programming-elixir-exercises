defmodule Handler do
  def result_handler(param) do
    case param do
      {:ok, x} -> x
      {_, message} -> raise "#{message}"
    end
  end
end
