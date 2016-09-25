defmodule EpWithPriorPortionsTest do
  use ExUnit.Case, async: true
  alias Apportion, as: A
  doctest A

  @weights %{a: 41, b: 32, c: 27}

  test "distribute/3 7" do
    assert %{a: 3, b: 2, c: 2} == A.distribute(@weights, 7, prior_portions: %{a: 3, b: 2, c: 2})
    assert %{a: 4, b: 2, c: 1} == A.distribute(@weights, 7, prior_portions: %{a: 4, b: 0, c: 0})
    assert %{a: 5, b: 1, c: 1} == A.distribute(@weights, 7, prior_portions: %{a: 5, b: 0, c: 0})
    assert %{a: 6, b: 1, c: 0} == A.distribute(@weights, 7, prior_portions: %{a: 6, b: 0, c: 0})
    assert %{a: 7, b: 0, c: 0} == A.distribute(@weights, 7, prior_portions: %{a: 7, b: 0, c: 0})
  end

  test "distribute/3 10" do
    assert %{a: 5, b: 2, c: 3} == A.distribute(@weights, 10, prior_portions: %{a: 5, b: 0, c: 3})
  end
end
