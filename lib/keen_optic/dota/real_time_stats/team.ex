defmodule KeenOptic.RealTimeStats.Team do
  @moduledoc """
  Represents a team from a real time match.

  Example data
  [
    %{
      "net_worth" => 42876,
      "players" => [
      ],
      "score" => 37,
      "team_id" => 0,
      "team_logo" => 0,
      "team_logo_url" => "",
      "team_name" => "",
      "team_number" => 2,
      "team_tag" => ""
    },
    %{
      "net_worth" => 36609,
      "players" => [
      ],
      "score" => 22,
      "team_id" => 0,
      "team_logo" => 0,
      "team_logo_url" => "",
      "team_name" => "",
      "team_number" => 3,
      "team_tag" => ""
    }
  ]
  """
  use KeenOptic.ExternalData

  alias KeenOptic.RealTimeStats.Player

  @primary_key false
  embedded_schema do
    field :net_worth, :integer
    field :score, :integer
    embeds_many :players, Player
  end

  @impl true
  def extra_changes(changeset, params) do
    players = params |> Map.get("players", []) |> Player.new()

    case players do
      {:ok, players} -> put_embed(changeset, :players, players)
      {:error, _error} = error -> error
    end
  end
end
