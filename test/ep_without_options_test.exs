defmodule EpWithoutOptionsTest do 
  use ExUnit.Case, async: true
  alias Apportion, as: A
  alias Apportion.Util
  doctest A

  @weights %{a: 41, b: 32, c: 27}

  test "distribute/3 1" do
    assert %{a: 1, b: 0, c: 0} == A.distribute(@weights, 1)
  end

  test "distribute/3 2" do
    assert %{a: 1, b: 1, c: 0} == A.distribute(@weights, 2)
  end

  test "distribute/3 3" do
    assert %{a: 1, b: 1, c: 1} == A.distribute(@weights, 3)
  end

  test "distribute/3 4" do
    assert %{a: 2, b: 1, c: 1} == A.distribute(@weights, 4)
  end

  test "distribute/3 10" do
    assert %{a: 4, b: 3, c: 3} == A.distribute(@weights, 10)
  end

  test "US census 2010" do
    path_to_fixtures = "test/fixtures/census"
    populations = Util.file_read_json_to_map(path_to_fixtures, "populations_2010.json")
    apportionment = Util.file_read_json_to_map(path_to_fixtures, "apportionment_2010.json")
    assert apportionment == A.distribute(populations, 435)
  end

  test "distribute/3 3 w greatly unbalanced weights" do
    n = Apportion.Algorithm.EqualProportions.big_number
    assert %{a: 1, b: 1, c: 1} == A.distribute(%{a: 1, b: 2, c: n}, 3)
    assert %{a: 0, b: 1, c: 2} == A.distribute(%{a: 1, b: 2, c: n * 2}, 3)
    assert %{a: 0, b: 1, c: 2} == A.distribute(%{a: 1, b: 2, c: n * 4}, 3)
    assert %{a: 0, b: 0, c: 3} == A.distribute(%{a: 1, b: 2, c: n * 8}, 3)
  end
end
