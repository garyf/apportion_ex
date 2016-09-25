defmodule Apportion.Algorithm.EqualProportions do
  @moduledoc """
  Selects the next recipient

  see Balinski, M. and H. Young, The Quota Method of Apportionment,
    Amer. Math. Monthly 82 (1975) 701-730.
  """

  @doc """
  Selects the next recipient by sorting the equal proportions rank-index of the recipients

  ## Example
      iex> weights = %{a: 41, b: 32, c: 27}
      ...> portions = %{a: 4, b: 3, c: 2}
      ...> Apportion.Algorithm.EqualProportions.recipient(weights, portions)
      :c
  """
  def recipient(weights, portions) do
    {k, _v} = Enum.max_by(weights, fn {k, v} -> recipient_rank(v, Map.fetch!(portions, k)) end)
    k
  end

  defp recipient_rank(weight, portion) when portion == 0, do: zero_rank(weight)
  defp recipient_rank(weight, portion), do: weight / :math.sqrt(portion * (portion + 1))

  # protect from division by zero
  defp zero_rank(weight), do: weight * big_number

  def big_number, do: :math.pow(2, 30)
end
