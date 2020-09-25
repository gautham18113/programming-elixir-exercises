defmodule FibServer do
  def fib(scheduler) do
    send scheduler, {:ready, self()}
    receive do
      {:fib, n, client} ->
        send client, {:answer, n, do_fib(n), self()}
        fib(scheduler)
      :shutdown ->
        exit(:normal)
    end
  end

  defp do_fib(0), do: 0
  defp do_fib(1), do: 1
  defp do_fib(n), do: do_fib(n-1) + do_fib(n-2)
end

defmodule Scheduler do
  def run(num_processes, queue, module, func) do
    1..num_processes
    |> Enum.map(fn(_) -> spawn module, func, [self()] end)
    |> do_schedule(queue, [])
  end

  def do_schedule(processes, queue, acc) do

    receive  do
      {:ready, pid} when queue != [] ->
        [h | t] = queue
        send pid, {:fib, h, self()}
        do_schedule(processes, t, acc)

      {:ready, pid} ->
        send pid, :shutdown

        if length(processes) > 1 do
          do_schedule(List.delete(processes, pid), queue, acc)
        else
          Enum.sort(acc, fn {n1, _}, {n2, _} -> n1 <= n2 end)
        end

      {:answer, num, result, _pid}  ->
        do_schedule(processes, queue, [{num, result} | acc])

    end
  end
end


to_process = List.duplicate(37, 20)

Enum.each 10..20, fn num_processes ->
  {time, result} = :timer.tc(
    Scheduler, :run,
    [num_processes, to_process, FibServer, :fib]
  )

  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n #   time (s)"
  end
  :io.format "~2B     ~.2f~n", [num_processes, time/1000000.0]
end
