defmodule Apportion.Setup do
  @moduledoc """
  Setup functions
  """

  @doc """
  Determines initial portions for recipients per optional constraints

  ## Example
      iex> keys = [:a, :b, :c]
      ...> Apportion.Setup.initial_portions(keys, required_minimum: 2)
      %{a: 2, b: 2, c: 2}
  """
  def initial_portions(keys, options) do
    min = options[:required_minimum] || 0
    portions = Map.new(keys, fn x -> {x, min} end)
    include_prior_portions(portions, options[:prior_portions])
  end

  defp include_prior_portions(portions, nil), do: portions
  defp include_prior_portions(portions, prior_portions) do
    Map.merge(portions, prior_portions, fn (_k, v0, v1) -> Enum.max([v0, v1]) end)
  end

  def validate(quantity, portions_sum) when quantity < portions_sum do
    raise "Quantity less than minimum portions_sum"
  end
  def validate(_, _), do: nil
end
