defmodule Parallel do
  def receiver(pid) do
    IO.inspect pid
    receive do { ^pid, result } -> result end
  end
  def pmap(collection, fun) do
    me = self()
    # me here denotes the process calling pmap
    IO.inspect me
    collection
    |> Enum.map(fn (elem) ->
         # self() here denotes the calling map process
         spawn_link fn -> (send me, { self(), fun.(elem) }) end
       end)
    |> Enum.map(&receiver(&1))
  end
end
