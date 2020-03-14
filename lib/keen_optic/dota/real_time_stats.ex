defmodule KeenOptic.Dota.RealTimeStats do
  @moduledoc """
  A struct with data about a current live dota game.
  """
  use Ecto.Schema

  import Ecto.Changeset

  alias __MODULE__
  alias KeenOptic.Dota.Match
  alias KeenOptic.RealTimeStats.Team

  @radiant_id 2
  @dire_id 3

  @allowed_params ~w(match_id server_steam_id)a

  @primary_key {:match_id, :id, autogenerate: false}
  embedded_schema do
    field :server_steam_id, :integer

    embeds_one :match, Match
    embeds_one :radiant, Team
    embeds_one :dire, Team
  end

  def new(params) when is_map(params) do
    match = Map.get(params, "match")
    teams = Map.get(params, "teams", [])

    with {:ok, match} <- Match.new(match),
         {:ok, radiant} <- extract_team(teams, @radiant_id),
         {:ok, dire} <- extract_team(teams, @dire_id) do
      params
      |> (&cast(%RealTimeStats{}, &1, @allowed_params)).()
      |> put_embed(:match, match)
      |> put_embed(:radiant, radiant)
      |> put_embed(:dire, dire)
      |> apply_action(:insert)
    else
      {:error, error} -> {:error, error}
    end
  end

  defp extract_team(teams, team_id) do
    case Enum.find(teams, fn team -> Map.get(team, "team_number") == team_id end) do
      nil -> {:error, "Missing team with id #{team_id}."}
      team -> Team.new(team)
    end
  end
end
