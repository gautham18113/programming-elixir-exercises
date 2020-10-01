defmodule Stack.Stash do
  use GenServer

  def start_link(initial_stack) do
    GenServer.start_link(__MODULE__, initial_stack, name: __MODULE__,trace: [:debug])
  end

  def get() do
    GenServer.call(__MODULE__, :get)
  end

  def update(val) do
    GenServer.cast(__MODULE__, {:update, val})
  end

  def init(stack) do
    {:ok, stack}
  end

  def handle_call(:get, _from, current_member) do
    {:reply, current_member, current_member}
  end

  def handle_cast({:update, new}, _) do
    {:noreply, new}
  end
end
