defmodule Subtyping do
  def spawner do
    fn {:number, n} when is_integer(n) -> n end
  end

  def pid_sender(f) do
    f.({:text, "Hello"})
  end

  def main do
    f = spawner()
    # f.({:text, "Hello"})
    pid_sender(f)
  end
end
