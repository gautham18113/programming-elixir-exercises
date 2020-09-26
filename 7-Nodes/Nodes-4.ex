defmodule ClientRing do

  @name :cr

  def start do
    pid = spawn __MODULE__, :handle_update, [[]]
    :global.register_name(@name, pid)
  end

  def register(pid) do
    send :global.whereis_name(@name), {:register, pid}
  end

  def handle_update(clients) do
    receive do
      {:register, pid} ->
        updated = clients ++ [pid]

        if clients == [] do
          # If there is only one process running, chain
          # it to itself
          send pid, {:next, pid}
        else
          # Chain once using reduce
          Enum.reduce(updated, fn (a,b) -> (
            send b, {:next, a}
            a) end)
          # Chain last to first
          send List.last(updated), {:next, List.first(updated)}
        end
        send List.first(updated), :tick
        handle_update(updated)
    end
  end

end

defmodule Client do
  def register(name) do
    ClientRing.register(self())
    await_next(name, nil)
  end

  def await_next(name, next) do
    receive do
      {:next, pid} ->
        IO.puts "#{name} received next pid #{inspect pid}"
        await_next(name, pid)
      :tick when next != nil ->
        IO.puts "Tock from #{name}"
        :timer.sleep 5000
        send next, :tick
        await_next(name, next)
      :tick ->
        IO.puts "Tock from #{name}"
        await_next(name, next)
    end
  end
end
