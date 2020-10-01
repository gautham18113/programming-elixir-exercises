defmodule Times do
  defmacro times_n(n) do
    fn_name = String.to_atom("times_" <> Integer.to_string(n))
    quote do
      def unquote(fn_name)(x) do
        x * unquote(n)
      end
    end
  end
end

defmodule Test do
  require Times
  Times.times_n(2)
  Times.times_n(3)
end
