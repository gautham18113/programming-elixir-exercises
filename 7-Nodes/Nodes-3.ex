defmodule Ticker do
  @interval 6000
  @name :ticker

  def start do
    generator([])
  end

  def register(client_pid) do
    IO.inspect :global.whereis_name(@name)
    send :global.whereis_name(@name), {:register, client_pid}
  end

  def generator(clients) do
    IO.puts "Start ticker"
    ticker_pid = spawn __MODULE__, :ticker, [clients]
    IO.puts "Start listening for register event"
    listen_pid = spawn __MODULE__, :listen_register, [ticker_pid]
    :global.register_name(@name, listen_pid)
  end

  def listen_register(ticker_pid) do
    receive do
      {:register, client_pid} ->
        IO.puts "Registered client"
        IO.inspect client_pid
        send ticker_pid, {:add_client, client_pid}
        listen_register(ticker_pid)
    end
  end

  def ticker(clients) do
    IO.puts "tick"

    if clients != [] do
      Enum.each(Enum.reverse(clients), fn client -> (
        :timer.sleep(2000)
        send client, :tick) end)
    end

    receive do
      {:add_client, new_client} ->
        ticker([new_client | clients])
    after
      @interval ->
        ticker(clients)
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
