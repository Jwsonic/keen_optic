defmodule KeenOptic.Dota.PickBan do
  @moduledoc """
  A struct with data about a pick or ban in a dota game.
  """

  use Ecto.Schema

  import Ecto.Changeset
  import KeenOptic.Ecto.Utils

  alias __MODULE__

  @required_attrs ~w(hero team)a

  embedded_schema do
    field :hero, :integer
    field :team, :integer
  end

  @spec new(map() | list(map())) :: {:ok, Pick.t()} | {:error, Ecto.Changeset.t()}
  def new(list) when is_list(list) do
    reduce_results(list, &new/1)
  end

  def new(params) do
    params
    |> (&cast(%PickBan{}, &1, @required_attrs)).()
    |> apply_action(:insert)
  end
end
