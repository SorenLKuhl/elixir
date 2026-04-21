defmodule SimpleFunction do
  def add_one(x) do
    x + 1
  end

  def test_ok do
    add_one(5)
  end

  # This should ERROR - add_one expects an integer, but we're passing a binary
  def test_error do
    add_one("not a number")
  end
end
