defmodule KeenOptic.Dota.PickBan do
  @moduledoc """
  A struct with data about a pick or ban in a dota game.
  """
  use TypedStruct

  alias __MODULE__

  typedstruct do
    field :hero, non_neg_integer(), enforce: true
    field :team, non_neg_integer(), enforce: true
  end

  @spec from_map(list(map())) :: list(Pick.t()) | {:error, String.t()}
  def from_list(list) do
    results =
      list
      |> Enum.map(&from_map/1)
      |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))

    case results[:error] do
      nil -> {:ok, results[:ok]}
      [error | _rest] -> error
    end
  end

  @spec from_map(map()) :: {:ok, Pick.t()} | {:error, String.t()}
  def from_map(%{"hero" => hero, "team" => team}) do
    {:ok,
     %PickBan{
       hero: hero,
       team: team
     }}
  end

  def from_map(map), do: {:error, "Does not match Pick shape #{inspect(map)}."}
end
