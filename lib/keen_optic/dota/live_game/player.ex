defmodule KeenOptic.Dota.LiveGame.Player do
  @moduledoc """
  A struct with data about a current player in a dota game.
  """
  use KeenOptic.ExternalData

  alias KeenOptic.Dota.Hero

  @primary_key {:account_id, :id, autogenerate: false}
  embedded_schema do
    embeds_one :hero, Hero
  end

  @impl true
  def extra_changes(changeset, params) do
    hero = params |> Map.get("hero_id") |> Hero.hero()

    put_embed(changeset, :hero, hero)
  end
end
