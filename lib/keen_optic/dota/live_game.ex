defmodule KeenOptic.Dota.LiveGame do
  @moduledoc """
  A struct with data about a current live dota game.
  """
  use TypedStruct

  alias __MODULE__

  alias KeenOptic.Dota.Player

  # "activate_time": 1581969536,
  # "deactivate_time": 0,
  # "server_steam_id": 90132752650106887,
  # "lobby_id": 26538656905582663,
  # "league_id": 0,
  # "lobby_type": 7,
  # "game_time": 1345,
  # "delay": 120,
  # "spectators": 970,
  # "game_mode": 22,
  # "average_mmr": 8234,
  # "match_id": 5248032065,
  # "series_id": 0,
  # "sort_score": 9704,
  # "": 1581971072,
  # "radiant_lead": -3724,
  # "radiant_score": 15,
  # "dire_score": 16,
  # "players": [
  #   {
  #     "account_id": 129035220,
  #     "hero_id": 111
  #   },
  #
  # ],
  # "building_state": 10092753

  typedstruct do
    field :activate_time, non_neg_integer()
    field :server_steam_id, non_neg_integer(), enforce: true
    field :lobby_id, non_neg_integer()
    field :lobby_type, non_neg_integer()
    field :game_time, non_neg_integer(), enforce: true
    field :delay, non_neg_integer()
    field :spectators, non_neg_integer(), enforce: true
    field :game_mode, non_neg_integer(), enforce: true
    field :average_mmr, non_neg_integer(), enforce: true
    field :match_id, non_neg_integer()
    field :series_id, non_neg_integer()
    field :last_update_time, non_neg_integer()
    field :radiant_lead, integer(), enforce: true
    field :radiant_score, non_neg_integer(), enforce: true
    field :dire_score, non_neg_integer(), enforce: true
    field :players, list(map()), enforce: true
    field :building_state, integer()
  end

  @spec from_list(list(map)) :: {:ok, list(LiveGame.t())} | {:error, String.t()}
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

  @spec from_map(map()) :: {:ok, list(LiveGame.t())} | {:error, String.t()}
  def from_map(
        %{
          "average_mmr" => average_mmr,
          "dire_score" => dire_score,
          "game_mode" => game_mode,
          "game_time" => game_time,
          "radiant_lead" => radiant_lead,
          "radiant_score" => radiant_score,
          "server_steam_id" => server_steam_id,
          "spectators" => spectators
        } = data
      ) do
    players = Map.get(data, "players", [])

    case Player.from_list(players) do
      {:ok, players} ->
        {:ok,
         %LiveGame{
           players: players,
           server_steam_id: server_steam_id,
           game_time: game_time,
           spectators: spectators,
           game_mode: game_mode,
           average_mmr: average_mmr,
           radiant_lead: radiant_lead,
           radiant_score: radiant_score,
           dire_score: dire_score
         }}

      {:error, message} ->
        {:error, message}
    end
  end
end
