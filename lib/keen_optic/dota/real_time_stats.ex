defmodule KeenOptic.Dota.RealTimeStats do
  @moduledoc """
  A struct with data about a current live dota game.
  """
  use KeenOptic.ExternalData

  alias KeenOptic.Dota.Match
  alias KeenOptic.Dota.RealTimeStats.Team

  @radiant_id 2
  @dire_id 3

  @primary_key {:match_id, :id, autogenerate: false}
  embedded_schema do
    field :server_steam_id, :integer

    embeds_one :match, Match
    embeds_one :radiant, Team
    embeds_one :dire, Team
  end

  @impl true
  def extra_changes(changeset, params) do
    match = Map.get(params, "match")
    teams = Map.get(params, "teams", [])

    with {:ok, match} <- Match.new(match),
         {:ok, radiant} <- extract_team(teams, @radiant_id),
         {:ok, dire} <- extract_team(teams, @dire_id) do
      changeset
      |> put_embed(:match, match)
      |> put_embed(:radiant, radiant)
      |> put_embed(:dire, dire)
    else
      {:error, _error} = error -> error
    end
  end

  defp extract_team(teams, team_id) do
    case Enum.find(teams, fn team -> Map.get(team, "team_number") == team_id end) do
      nil -> {:error, "Missing team with id #{team_id}."}
      team -> Team.new(team)
    end
  end
end
