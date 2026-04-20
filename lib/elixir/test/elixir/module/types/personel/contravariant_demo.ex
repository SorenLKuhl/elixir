defmodule ContravariantDemo do
  @moduledoc """
  This module demonstrates contravariant type checking for pids.

  The function `pid_sender/1` is hardcoded to check that its pid parameter
  can receive {:text, binary()} messages, since that's what it sends.
  """

  # This function sends {:text, binary()} to whatever pid is passed
  def pid_sender(pid) do
    send(pid, {:text, "Hello from sender"})
  end

  # def test_ok do
  #   # Create a pid that accepts {:text, binary()}
  #   pid =
  #     spawn(fn ->
  #       receive do
  #         {:text, msg} when is_binary(msg) ->
  #           IO.puts(msg)
  #       end
  #     end)

  #   # This should be OK - pid accepts {:text, binary()}
  #   pid_sender(pid)
  # end

  def test_error do
    # Create a pid that only accepts {:number, integer()}
    pid =
      spawn(fn ->
        receive do
          {:number, n} when is_integer(n) ->
            n + 5
        end
      end)

    # This should ERROR - pid_sender sends {:text, binary()}
    # but this pid only accepts {:number, integer()}
    pid_sender(pid)
  end

  # def test_union_ok do
  #   # Create a pid that accepts both {:text, binary()} and {:number, integer()}
  #   pid =
  #     spawn(fn ->
  #       receive do
  #         {:text, msg} when is_binary(msg) ->
  #           IO.puts(msg)

  #         {:number, n} when is_integer(n) ->
  #           n + 5
  #       end
  #     end)

  #   # This should be OK - pid accepts {:text, binary()} among others
  #   pid_sender(pid)
  # end
end
