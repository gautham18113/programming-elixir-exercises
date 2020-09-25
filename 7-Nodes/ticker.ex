defmodule Ticker do
  @interval 2000
  @name :ticker

  def start do
    pid = spawn __MODULE__, :generator, [[]]
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), {:register, client_pid}
  end

  def generator(clients) do
    receive do
      {:register, client_pid} ->
        generator([client_pid | clients])
    after
      @interval ->
        IO.puts "tick"
        Enum.each clients, fn client -> send client, :tick end
        generator(clients)
    end

  end
end

defmodule Client do
  def register_client(name) do
    Ticker.register(self())
    receive_tick(name)
  end
  def receive_tick(name) do
    receive do
      :tick ->
        IO.puts "Tock from #{name}!"
        receive_tick(name)
    end
  end

end
