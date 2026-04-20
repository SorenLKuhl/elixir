defmodule SimpleGenServer do
 use GenServer
   def start_link() do
    {_, pid} = GenServer.start_link(__MODULE__, [])
    pid
  end

  def add_one(pid) do
    GenServer.call(pid, {:add_one, "Hello world"})
  end

  @impl true
  def init(default) do
    {:ok, default}
  end

  @impl true
  def handle_call({:add_one, x}, _from, state) do
    {:reply, x + 1, state}
  end
end
