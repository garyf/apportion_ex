defmodule Apportion.Util do
  @moduledoc """
  Utility functions
  """

  @doc """
  Reads a JSON file and returns a map with atoms as keys

  ## Example
      iex> path_to_directory = "test/fixtures/balinski"
      ...> json_file_name = "table_9_populations.json"
      ...> Apportion.Util.file_read_json_to_map(path_to_directory, json_file_name)
      %{a: 9061, b: 7179, c: 5259, d: 3319, e: 1182}
  """
  def file_read_json_to_map(path_to_directory, json_file_name) do
    {:ok, map} = Path.join(path_to_directory, json_file_name)
      |> File.read!
      |> Poison.decode(keys: :atoms)
    map
  end

  @doc """
  Sums all of the values in a map

  ## Example
      iex> Apportion.Util.map_values_sum(%{a: 8, b: 2, c: 3})
      13
  """
  def map_values_sum(map) do
    Enum.reduce(map, 0, fn ({_k, v}, acc) -> v + acc end)
  end
end
