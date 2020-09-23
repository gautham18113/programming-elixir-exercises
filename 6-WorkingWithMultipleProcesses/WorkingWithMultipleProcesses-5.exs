defmodule SpawnMonitor do
  def child(pid) do
    send pid, "hello"
    exit(:boom)
  end

  def parent do
    spawn_monitor(SpawnMonitor, :child, [self()])
    :timer.sleep(500)
    receive do
      v ->
        IO.puts(v)
    after 1000 ->
      IO.puts "Nothing"
    end

  end
end

# Repeat the two, changing spawn_link to spawn_monitor.

# raise
# ---
# iex(4)> SpawnMonitor.parent()

# 01:17:48.539 [error] Process #PID<0.135.0> raised an exception
# ** (RuntimeError) oh no
#     6-WorkingWithMultipleProcesses/WorkingWithMultipleProcesses-5.exs:4: SpawnMonitor.child/1
# hello
# :ok
# ---


# exit
# ---
# iex(4)> SpawnMonitor.parent()
# hello
# :ok
# ---
