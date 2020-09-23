defmodule SpawnLink do
  def child(pid) do
    send pid, "hello"
    exit(:bye)
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
# iex(11)> SpawnLink.parent()
# ** (EXIT from #PID<0.106.0>) shell process exited with reason: :bye
#---

#---
# Does it matter that you weren’t waiting for the notification
# from the child when it exited?
#  No
#---
