defmodule TypedPidSendTest do
  def start_link do
    spawn(fn -> counter(0) end)
  end

  defp counter(count) do
    receive do
      {:get_count, caller} ->
        send(caller, {:ok, count})
        counter(count)

      :increment ->
        counter(count + 1)
    end
  end

  def get_count(pid) do
    send(pid, {:get_count, self()})

    receive do
      {:ok, count} -> count
    end
  end


  # def test_send_wrong_type do
  #   pid =
  #     spawn(fn ->
  #       receive do
  #         {:number, n} when is_integer(n) ->
  #           n + 5
  #       end
  #     end)

  #   pid
  # end

  # # Is there a way to enforce the type of the pid without using guards?
  # # sender(pid) accepts the default: pid({:term, :none}), it does not carry the type from the calling funciton.
  # def sender(pid) do
  #   send(pid, {:other, 5})
  # end

  # def main do
  #   pid = test_send_wrong_type()
  #   send(pid, {:other, 5})
  #   # sender(pid)
  # end
end
