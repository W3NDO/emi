defmodule EmiCoreTest do
  use ExUnit.Case
  doctest EmiCore

  test "greets the world" do
    assert EmiCore.hello() == :world
  end
end
