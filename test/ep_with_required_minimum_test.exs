defmodule EpWithRequiredMinimumTest do
  use ExUnit.Case, async: true
  alias Apportion, as: A
  alias Apportion.Util
  doctest A

  @weights %{a: 61, b: 21, c: 18}

  test "distribute/3 2 raises" do
    message = "Quantity less than minimum portions_sum"
    assert_raise RuntimeError, message, fn -> A.distribute(@weights, 2, required_minimum: 1) end
  end

  test "distribute/3 3" do
    assert %{a: 1, b: 1, c: 1} == A.distribute(@weights, 3, required_minimum: 1)
  end

  test "distribute/3 6" do
    assert %{a: 2, b: 2, c: 2} == A.distribute(@weights, 6, required_minimum: 2)
  end

  test "distribute/3 10" do
    assert %{a: 6, b: 2, c: 2} == A.distribute(@weights, 10, required_minimum: 2)
  end

  test "US census 2010" do
    path_to_fixtures = "test/fixtures/census"
    populations = Util.file_read_json_to_map(path_to_fixtures, "populations_2010.json")
    apportionment = Util.file_read_json_to_map(path_to_fixtures, "apportionment_2010.json")
    assert apportionment == A.distribute(populations, 435, required_minimum: 1)
  end

  test "distribute/3 3 w greatly unbalanced weights" do
    n = Apportion.Algorithm.EqualProportions.big_number
    minimums = %{a: 1, b: 1, c: 1}
    assert minimums == A.distribute(%{a: 1, b: 2, c: n}, 3, required_minimum: 1)
    assert minimums == A.distribute(%{a: 1, b: 2, c: n * 2}, 3, required_minimum: 1)
    assert minimums == A.distribute(%{a: 1, b: 2, c: n * 4}, 3, required_minimum: 1)
    assert minimums == A.distribute(%{a: 1, b: 2, c: n * 8}, 3, required_minimum: 1)
  end
end
