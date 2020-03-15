defmodule KeenOptic.Dota.PickBan do
  @moduledoc """
  A struct with data about a pick or ban in a dota game.
  """
  use KeenOptic.ExternalData

  @primary_key false
  embedded_schema do
    field :hero, :integer
    field :team, :integer
  end
end
