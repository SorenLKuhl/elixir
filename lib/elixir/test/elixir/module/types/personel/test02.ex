defmodule Subtyping do
  @spec spawner() :: ({:number, integer()} -> integer())
  def spawner do
    fn {:number, n} when is_integer(n) -> n end
  end

  @spec pid_sender(f :: ({:number, integer()} -> integer())) :: integer()
  def pid_sender(f) do
    f.({:text, "Hello"})
  end

  @spec main :: integer()
  def main do
    f = spawner()
    # f.({:text, "Hello"})
    pid_sender(f)
  end
end
