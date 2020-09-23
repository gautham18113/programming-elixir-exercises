defmodule SpawnLink do
  def child(pid) do
    send pid, "hello"
    raise "Oh No!"
  end

  def parent do
    spawn_link(SpawnLink, :child, [self()])
    :timer.sleep(500)
    receive do
      v ->
        IO.puts(v)
    after 1000 ->
      IO.puts "Nothing"
    end

  end
end


#---
# Do the same, but have the child raise an exception. What difference do
# you see in the tracing?
#
#
#---
# iex(3)> SpawnLink.parent()
# ** (EXIT from #PID<0.126.0>) shell process exited with reason: an exception was raised:
#     ** (RuntimeError) Oh No!
#         6-WorkingWithMultipleProcesses/WorkingWithMultipleProcesses-4.exs:4: SpawnLink.child/1#---
#---
