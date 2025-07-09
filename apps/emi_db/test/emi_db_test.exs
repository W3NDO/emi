defmodule EmiDbTest do
  use ExUnit.Case
  doctest EmiDb

  test "greets the world" do
    assert EmiDb.hello() == :world
  end
end
