defmodule KeenOptic.Dota.RealTimeStats do
  @moduledoc """
  A struct with data about a current live dota game.
  """
  use TypedStruct

  alias __MODULE__
  alias KeenOptic.Dota.Match
  alias KeenOptic.RealTimeStats.Team

  @radiant_id 2
  @dire_id 3

  typedstruct do
    field :match, Match.t(), enforce: true
    field :teams, list(), enforce: true
    field :buildings, list(), enforce: true
    field :graph_data, Match.t(), enforce: true
    field :delta_frame, boolean(), enforce: true
    field :radiant, Team.t(), enforce: true
    field :dire, Team.t(), enforce: true
  end

  @spec from_map(map()) :: {:ok, RealTimeStats.t()} | {:error, String.t()}
  def from_map(%{
        "match" => match,
        "teams" => teams,
        "buildings" => buildings,
        "graph_data" => graph_data
      }) do
    with {:ok, match} <- Match.from_map(match),
         {:ok, radiant} <- extract_team(teams, @radiant_id),
         {:ok, dire} <- extract_team(teams, @dire_id) do
      {:ok,
       %RealTimeStats{
         match: match,
         teams: teams,
         buildings: buildings,
         graph_data: graph_data,
         delta_frame: false,
         radiant: radiant,
         dire: dire
       }}
    else
      error -> error
    end
  end

  defp extract_team(teams, team_id) do
    case Enum.find(teams, fn team -> Map.get(team, "team_number") == team_id end) do
      nil -> {:error, "Missing team with id #{team_id}."}
      team -> Team.from_map(team)
    end
  end
end
