defmodule KeenOptic.Dota.Match do
  @moduledoc """
  A struct with data about a current live dota game.
  """

  use TypedStruct

  alias __MODULE__
  alias KeenOptic.Dota.PickBan

  # %{
  #   "game_mode" => 22,
  #   "game_state" => 5,
  #   "game_time" => 2445,
  #   "league_id" => 0,
  #   "league_node_id" => 0,
  #   "matchid" => 5245062703,
  #   "server_steam_id" => 90132710801809418,
  #   "timestamp" => 2804
  # }

  typedstruct do
    field :server_steam_id, non_neg_integer(), enforce: true
    field :matchid, non_neg_integer(), enforce: true
    field :timestamp, non_neg_integer(), enforce: true
    field :game_time, non_neg_integer(), enforce: true
    field :game_mode, non_neg_integer(), enforce: true
    field :league_id, non_neg_integer(), enforce: true
    field :league_node_id, non_neg_integer(), enforce: true
    field :game_state, non_neg_integer(), enforce: true
    field :picks, list(PickBan.t()), enforce: true
    field :bans, list(PickBan.t()), enforce: true
  end

  def from_map(
        %{
          "server_steam_id" => server_steam_id,
          "matchid" => matchid,
          "timestamp" => timestamp,
          "game_time" => game_time,
          "game_mode" => game_mode,
          "league_id" => league_id,
          "league_node_id" => league_node_id,
          "game_state" => game_state
        } = data
      ) do
    picks = Map.get(data, "picks", [])
    bans = Map.get(data, "bans", [])

    with {:ok, picks} <- PickBan.from_list(picks),
         {:ok, bans} <- PickBan.from_list(bans) do
      {:ok,
       %Match{
         server_steam_id: server_steam_id,
         matchid: matchid,
         timestamp: timestamp,
         game_time: game_time,
         game_mode: game_mode,
         league_id: league_id,
         league_node_id: league_node_id,
         game_state: game_state,
         picks: picks,
         bans: bans
       }}
    else
      {:error, message} -> {:error, message}
    end
  end
end
