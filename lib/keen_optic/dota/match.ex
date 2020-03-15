defmodule KeenOptic.Dota.Match do
  @moduledoc """
  A struct with match data about a current live dota game.
  """
  use KeenOptic.ExternalData

  alias KeenOptic.Dota.PickBan

  @picks_key "picks"
  @bans_key "bans"

  @primary_key {:server_steam_id, :id, autogenerate: false}
  embedded_schema do
    field :match_id, :integer
    field :game_time, :integer
    field :game_mode, :integer
    field :league_id, :integer
    field :game_state, :integer
    embeds_many :picks, PickBan
    embeds_many :bans, PickBan
  end

  @impl true
  def coerce_params(params) do
    case Map.get(params, "matchid") do
      nil -> {:error, "Missing key 'matchid'."}
      match_id -> {:ok, Map.put(params, "match_id", match_id)}
    end
  end

  @impl true
  def extra_changes(changeset, params) do
    with {:ok, picks} <- extract(params, @picks_key),
         {:ok, bans} <- extract(params, @bans_key) do
      changeset
      |> put_embed(:picks, picks)
      |> put_embed(:bans, bans)
    else
      {:error, error} -> {:error, error}
    end
  end

  defp extract(params, key) do
    params |> Map.get(key, []) |> PickBan.new()
  end
end
