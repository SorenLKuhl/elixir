defmodule SimpleGenServer do
  use GenServer

  def start_link() do
    {:ok, pid} = GenServer.start_link(__MODULE__, [])
    pid
  end

  def strict_add_one(pid, x) when is_integer(x) do
    GenServer.call(pid, {:add_one, x})
  end

  @impl true
  def init(default) do
    {:ok, default}
  end

  @impl true
  def handle_call({:add_one, x}, _from, state) do
    {:reply, x + 1.1, state}
  end

  @impl true
  def handle_call({:add_string, x}, _from, state) when is_binary(x) do
    {:reply, x <> "Test", state}
  end

  def main do
    pid = start_link()
    # x = GenServer.call(pid, {:add_string, "Hello"})
    # x <> " world"
    x = strict_add_one(pid, 42)
    x <> "Hello world"
  end
end
