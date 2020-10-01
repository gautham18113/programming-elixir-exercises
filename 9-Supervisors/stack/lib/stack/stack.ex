defmodule Stack.Server do
  use GenServer

  @server Stack.Server

  def start_link(_) do
    GenServer.start_link(@server, nil, name: @server, debug: [:trace])
  end

  def push(item) do
    GenServer.cast(@server, {:push, item})
  end

  def pop() do
    GenServer.call(@server, :pop)
  end

  def stop() do
    GenServer.call(@server, :stop)
  end


  def init(_) do
    {:ok, Stack.Stash.get()}
  end

  def handle_call(:pop, _from, []) do
    {:reply, [], []}
  end

  def handle_call(:pop, _from, [h|t]) do
    {:reply, h, t}
  end

  def handle_call(:stop, _, _) do
    raise "I'm an error!"
  end

  def handle_cast({:push, n}, current) do
    {:noreply, current ++ [n]}
  end

  def terminate(_reason, current_member) do
    Stack.Stash.update(current_member)
  end
end
