defmodule KeenOptic.Dota.Player do
  @moduledoc """
  A struct with data about a current player in a dota game.
  """
  use TypedStruct

  alias __MODULE__

  typedstruct do
    field :account_id, non_neg_integer(), enforce: true
    field :hero_id, non_neg_integer(), enforce: true
  end

  @spec from_list(list(map())) :: {:ok, list(Player.t())} | {:error, String.t()}
  def from_list(list) when is_list(list) do
    results =
      list
      |> Enum.map(&from_map/1)
      |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))

    case results[:error] do
      nil -> {:ok, results[:ok]}
      [error | _rest] -> error
    end
  end

  @spec from_map(map()) :: Player.t() | {:error, String.t()}
  def from_map(%{"account_id" => account_id, "hero_id" => hero_id}) do
    {:ok,
     %Player{
       account_id: account_id,
       hero_id: hero_id
     }}
  end

  def from_map(map), do: {:error, "Does not match Player shape #{inspect(map)}."}
end
