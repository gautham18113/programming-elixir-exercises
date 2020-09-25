defmodule FileServer do
  def process(scheduler) do
    send scheduler, {:ready, self()}
    receive do
      {:process, {path, regex}, client} ->
        send client, {:answer, {path, find_word_count(path, regex)}}
        process(scheduler)
      :shutdown ->
        exit(:normal)
    end
  end

  def find_word_count(path, regex) do
    path
    |> File.read!()
    |> (&Regex.scan(regex, &1)).()
    |> length()
  end
end

defmodule Scheduler do
  def run(module, func, func_args, n) do
    1..n
    |> Enum.map(fn (_) -> spawn module, func, [self()] end)
    |> do_schedule(func_args, [])
  end

  def do_schedule(processes, args, acc) do

    receive  do
      {:ready, pid} when args != [] ->
        [h | t] = args
        send pid, {:process, h, self()}
        do_schedule(processes, t, acc)

      {:ready, pid} ->
        send pid, :shutdown

        if length(processes) > 1 do
          do_schedule(List.delete(processes, pid), args, acc)
        else
          acc
        end

      {:answer, result}  ->
        do_schedule(processes, args, [result | acc])

    end
  end
end

defmodule FileCopy do
  def file_duplicate(n, path) do
    for x <- 1..n, do: File.copy!(path, "#{Path.dirname(path)}/#{Path.basename(path)}-#{x}#{Path.extname(path)}")
  end
end

path = ""
to_process = File.ls!(path)
|> Enum.map(fn x -> {"#{path}/#{x}", ~r/[\w\s]*lorem[\w\s]*/i} end)
|> Enum.take(500)


Enum.each 1000..1000, fn num_processes ->
  {time, result} = :timer.tc(
    Scheduler, :run,
    [FileServer, :process, to_process, num_processes]
  )
  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n #   time (s)"
  end
  :io.format "~2B     ~.2f~n", [num_processes, time/1000000.0]
end

#---
# 100 files, each 2.2 MB large
#   time (s)
# 1     96.59
# 2     51.98
# 3     38.24
# 4     30.62
# 5     26.60
# 6     23.75
# 7     22.11
# 8     20.44
# 9     22.37
# 10    21.43
#---
