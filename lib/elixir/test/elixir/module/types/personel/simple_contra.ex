defmodule SimpleContravariantTest do
  # Hardcoded function that sends {:text, binary()}
  def pid_sender(pid) do
    send(pid, {:text, "hello"})
  end

  def main do
    # Pid that only accepts {:number, integer()}
    pid =
      spawn(fn ->
        receive do
          {:number, n} when is_integer(n) -> n
        end
      end)

    # Should error - incompatible
    pid_sender(pid)
  end
end
