defmodule Spawn do
  def spawned_process do
    IO.puts "In spawned"
    receive do
      {sender, v} ->
        send(sender, "#{v}!")
    end

  end

  def sender do
    pid1 = spawn(Spawn, :spawned_process, [])
    pid2 = spawn(Spawn, :spawned_process, [])

    send(pid1,{self(), "betty"} )
    send(pid2,{self(), "fred"} )

    receive do
      v ->
        IO.puts v
    end
    receive do
      v ->
        IO.puts v
    end
  end
end
