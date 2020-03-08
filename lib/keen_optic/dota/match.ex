defmodule KeenOptic.Dota.Match do
  @moduledoc """
  A struct with match data about a current live dota game.
  """

  use Ecto.Schema

  import Ecto.Changeset
  import KeenOptic.Ecto.Utils

  alias __MODULE__
  alias KeenOptic.Dota.PickBan

  @type t() :: %Match{}

  @required_params ~w(server_steam_id matchid game_time game_mode league_id game_state picks bans)a
  @rename_pairs [{"matchid", "match_id"}]

  @primary_key {:server_steam_id, :id, autogenerate: false}
  embedded_schema do
    field :match_id, :integer
    field :game_time, :time
    field :game_mode, :integer
    field :league_id, :integer
    field :game_state, :integer
    embeds_many :picks, PickBan
    embeds_many :bans, PickBan
  end

  @picks_key "picks"
  @bans_key "bans"

  @spec new(map()) :: {:ok, Match.t()} | {:error, Ecto.Changeset.t()}
  def new(params) do
    with {:ok, picks} <- extract(params, @picks_key),
         {:ok, bans} <- extract(params, @bans_key) do
      params
      |> rename_params(@rename_pairs)
      |> (&cast(%Match{}, &1, @required_params)).()
      |> put_embed(:picks, picks)
      |> put_embed(:bans, bans)
      |> apply_action(:insert)
    else
      {:error, error} -> {:error, error}
    end
  end

  defp extract(params, key) do
    params |> Map.get(key, []) |> PickBan.new()
  end
end
