defmodule TypedPidSendTest do
  def test_send_wrong_type do
    pid =
      spawn(fn ->
        receive do
          {:number, n} when is_integer(n) ->
            n + 5
        end
      end)

    pid
  end

  # Is there a way to enforce the type of the pid without using guards?
  # pid_sender(pid) accepts the default: pid({:term, :none}), it does not carry the type from the calling funciton.

  def pid_sender(pid) do
    send(pid, {:text, 5})
  end

  def main do
    pid = test_send_wrong_type()

    pid_sender(pid)
    # send(pid, {:text, 5})
  end
end
