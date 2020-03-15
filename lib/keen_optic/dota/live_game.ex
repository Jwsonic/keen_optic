defmodule KeenOptic.Dota.LiveGame do
  @moduledoc """
  A struct with data about a current live dota game.

  "activate_time": 1581969536,
  "deactivate_time": 0,
  "server_steam_id": 90132752650106887,
  "lobby_id": 26538656905582663,
  "league_id": 0,
  "lobby_type": 7,
  "game_time": 1345,
  "delay": 120,
  "spectators": 970,
  "game_mode": 22,
  "average_mmr": 8234,
  "match_id": 5248032065,
  "series_id": 0,
  "sort_score": 9704,
  "": 1581971072,
  "radiant_lead": -3724,
  "radiant_score": 15,
  "dire_score": 16,
  "players": [
    {
      "account_id": 129035220,
      "hero_id": 111
    },

  ],
  "building_state": 10092753

  """
  use KeenOptic.ExternalData

  alias KeenOptic.Dota.LiveGame.Player

  @primary_key {:server_steam_id, :id, autogenerate: false}
  embedded_schema do
    field :game_time, :integer
    field :spectators, :integer
    field :game_mode, :integer
    field :radiant_lead, :integer
    field :average_mmr, :integer
    field :dire_score, :integer
    field :radiant_score, :integer
    field :league_id, :integer

    embeds_many :players, Player
  end

  @impl true
  def extra_changes(changeset, params) do
    players = params |> Map.get("players", []) |> Player.new()

    case players do
      {:ok, players} -> put_embed(changeset, :players, players)
      _ -> changeset
    end
  end
end
