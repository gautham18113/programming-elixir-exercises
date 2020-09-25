defmodule Spawn1 do
  def greet do
    receive do
      {sender, msg} ->
        send sender, { :ok, "Hello, #{msg}" }
    end
    greet()
  end
end

# here's a client
# pid = spawn(Spawn1, :greet, [])
# send pid, {self(), "World!"}

# receive do
#   {:ok, message} ->
#     IO.puts message
# end

# send pid, {self(), "Kizmit!"}

# receive do
#   {:ok, message} ->
#     IO.puts message
#   after 500 ->
#     IO.puts "the greeter has gone away"
#end
