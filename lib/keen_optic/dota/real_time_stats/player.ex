defmodule KeenOptic.RealTimeStats.Player do
  @moduledoc """
  Represents a player from real-time match data.

  Example data shape:
  %{
    "abilities" => [5082, 5083, 5084, 5085, 6405, 6029, 6028, 5928, 6004, 6408, 6037, 6861],
    "accountid" => 178_366_364,
    "assists_count" => 9,
    "death_count" => 3,
    "denies_count" => 13,
    "gold" => 2192,
    "heroid" => 15,
    "items" => [63, 75, 75, 36, 100, 116, 0, 0, 0],
    "kill_count" => 8,
    "level" => 19,
    "lh_count" => 170,
    "name" => "Dead Calm",
    "net_worth" => 11862,
    "playerid" => 0,
    "team" => 2,
    "x" => 0.22221094369888306,
    "y" => -0.3521626889705658
  }

  """
  use KeenOptic.ExternalData

  alias KeenOptic.Dota.Hero

  @primary_key {:account_id, :id, autogenerate: false}
  embedded_schema do
    field :name, :string
    field :x, :float
    field :y, :float

    embeds_one :hero, Hero
  end

  @impl true
  def coerce_params(params) do
    case Map.get(params, "accountid") do
      nil -> {:error, "Missing key 'accountid'."}
      account_id -> {:ok, Map.put(params, "account_id", account_id)}
    end
  end

  @impl true
  def extra_changes(changeset, params) do
    hero = params |> Map.get("heroid") |> Hero.hero()

    put_embed(changeset, :hero, hero)
  end
end
