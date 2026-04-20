defmodule TypedPidContravariantTest do
  def test_send_wrong_type do
    pid =
      spawn(fn ->
        receive do
          {:text, n} when is_binary(n) ->
            n

          {:number, n} when is_integer(n) ->
            n + 5
        end
      end)

    pid
  end

  # Hardcoded demonstration: pid_sender is known to send {:text, binary()}
  def pid_sender(pid) do
    send(pid, {:text, "hello"})
  end

  def main_ok do
    # This pid accepts {:text, binary()} so it should be OK
    pid = test_send_wrong_type()
    pid_sender(pid)
  end

  def main_error do
    # This pid only accepts {:number, integer()} so it should ERROR
    pid =
      spawn(fn ->
        receive do
          {:number, n} when is_integer(n) ->
            n + 5
        end
      end)

    pid_sender(pid)
  end
end
