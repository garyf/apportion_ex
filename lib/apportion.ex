defmodule Apportion do
  @moduledoc """
  Top level interface, or API, to proportionally distribute a quantity
  """

  alias Apportion.Algorithm.EqualProportions
  alias Apportion.Setup
  alias Apportion.Util

  @doc """
  Distributes a quantity proportionally among recipients per relative weights using the
    'equal proportions' algorithm

  ## Example
      iex> weights = %{a: 41, b: 32, c: 27}
      ...> Apportion.distribute(weights, 7)
      %{a: 3, b: 2, c: 2}
  """
  def distribute(weights, quantity, options \\ []) do
    portions = Setup.initial_portions(Map.keys(weights), options)
    portions_sum = Util.map_values_sum(portions)
    Setup.validate(quantity, portions_sum)
    next_step(weights, portions, portions_sum, quantity)
  end

  # recursively
  defp next_step(_, portions, portions_sum, quantity) when portions_sum == quantity do
    portions
  end
  defp next_step(weights, portions, portions_sum, quantity) do
    key = EqualProportions.recipient(weights, portions)
    next_portions = Map.merge(portions, %{key => Map.fetch!(portions, key) + 1})
    next_step(weights, next_portions, portions_sum + 1, quantity)
  end
end
