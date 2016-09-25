defmodule Algorithm.EqualProportionsTest do
  use ExUnit.Case, async: true
  alias Apportion.Algorithm.EqualProportions
  doctest EqualProportions

  @weights %{a: 41, b: 32, c: 27}

  test "recipient/2 0" do
    assert :a == EqualProportions.recipient(@weights, %{a: 0, b: 0, c: 0})
  end

  test "recipient/2 1" do
    assert :b == EqualProportions.recipient(@weights, %{a: 1, b: 0, c: 0})
  end

  test "recipient/2 2" do
    assert :c == EqualProportions.recipient(@weights, %{a: 1, b: 1, c: 0})
  end

  test "recipient/2 3" do
    assert :a == EqualProportions.recipient(@weights, %{a: 1, b: 1, c: 1})
  end

  test "recipient/2 9" do
    assert :c == EqualProportions.recipient(@weights, %{a: 4, b: 3, c: 2})
  end
end
