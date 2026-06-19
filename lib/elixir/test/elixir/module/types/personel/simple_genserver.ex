defmodule SimpleGenServer do
  use GenServer

  def start_link() do
    {:ok, pid} = GenServer.start_link(__MODULE__, 0)
    pid
  end

  def strict_add_one(pid, x) do
    strict_nested_add_one(pid, x)
  end

  def strict_nested_add_one(pid, x) when is_integer(x) do
    GenServer.call(pid, {:add_one, x})
  end

  def strict_add_string(pid, x) when is_binary(x) do
    GenServer.call(pid, {:add_string, x})
  end

  def strict_add_float(pid, x) when is_float(x) do
    strict_nested_add_float(pid, x)
  end

  def strict_nested_add_float(pid, x) do
    GenServer.cast(pid, {:add_float, x + 1.2})
  end

  @impl true
  def init(default) do
    {:ok, default}
  end

  @impl true
  def handle_call({:add_one, x}, _from, state) do
    {:reply, x + 1.0, state}
  end

  @impl true
  def handle_call({:add_string, x}, _from, state) do
    {:reply, x <> "Test", state}
  end

  @impl true
  def handle_cast({:add_float, x}, state) when is_float(x) do
    y = x + 1.1
    {:noreply, state + y}
  end

  def main do
    pid = start_link()
    # x = GenServer.call(pid, {:add_one, 42})
    # x = strict_add_float(pid, 42.0)
    # x <> " world"
    # GenServer.cast(pid, {:add_float, "42.0"})
    x = strict_add_string(pid, 42)
    x <> "Hello world"
  end
end
