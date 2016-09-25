defmodule SetupTest do
  use ExUnit.Case, async: true
  alias Apportion.Setup
  doctest Setup

  @keys [:a, :b, :c]

  test "initial_portions/2 w/o options" do
    assert %{a: 0, b: 0, c: 0} == Setup.initial_portions(@keys, [])
  end

  test "initial_portions/2 w required_minimum 2" do
    assert %{a: 2, b: 2, c: 2} == Setup.initial_portions(@keys, required_minimum: 2)
  end

  test "initial_portions/2 w prior_portions 16" do
    portions = %{a: 8, b: 3, c: 5}
    assert portions == Setup.initial_portions(@keys, prior_portions: portions)
  end

  test "initial_portions/2 w :b minimum > prior" do
    portions = %{a: 5, b: 0, c: 1}
    assert %{a: 5, b: 2, c: 2} ==
      Setup.initial_portions(@keys, [
        prior_portions: portions,
        required_minimum: 2
      ])
  end

  test "initial_portions/2 w minimum < prior" do
    portions = %{a: 8, b: 3, c: 5}
    assert portions ==
      Setup.initial_portions(@keys, [
        prior_portions: portions,
        required_minimum: 2
      ])
  end
end
