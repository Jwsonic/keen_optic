defmodule KeenOptic.Dota.LiveGame.Player do
  @moduledoc """
  A struct with data about a current player in a dota game.
  """
  use Ecto.Schema

  import Ecto.Changeset
  import KeenOptic.Ecto.Utils

  alias __MODULE__
  alias KeenOptic.Dota.Hero

  @required_params [:account_id, :hero_id]

  @primary_key {:account_id, :id, autogenerate: false}
  embedded_schema do
    field :hero_id, :integer

    embeds_one :hero, Hero
  end

  def new(params) when is_list(params) do
    reduce_results(params, &new/1)
  end

  def new(params) when is_map(params) do
    hero = params |> Map.get("hero_id") |> Hero.hero()

    params
    |> (&cast(%Player{}, &1, @required_params)).()
    |> put_embed(:hero, hero)
    |> apply_action(:insert)
  end
end
