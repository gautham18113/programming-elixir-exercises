defmodule Calculate do

  def calc(str) do
    _split(str, 0)
  end

  defp _split([], val), do: val

  defp _split([?\s | t], val), do: _split(t, val)

  defp _split([?+|t], val), do: val + _split(t, 0)

  defp _split([?-|t], val), do: val - _split(t, 0)

  defp _split([?*|t], val), do: val * _split(t, 0)

  defp _split([?/|t], val), do: val / _split(t, 0)

  defp _split([h|t], val), do: _split(t, (val * 10) + h - ?0)

end
