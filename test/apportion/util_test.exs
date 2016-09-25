defmodule ApportionUtilTest do
  use ExUnit.Case, async: true
  alias Apportion.Util
  doctest Util

  test "file_read_json_to_map/2" do
    map = %{a: 9061, b: 7179, c: 5259, d: 3319, e: 1182}
    assert map == Util.file_read_json_to_map("test/fixtures/balinski", "table_9_populations.json")
  end

  test "map_values_sum/1" do
    assert 13 == Util.map_values_sum(%{a: 8, b: 2, c: 3})
  end
end
