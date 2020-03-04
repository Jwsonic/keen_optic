defmodule KeenOptic.RealTimeStats.Player do
  @moduledoc """
  Represents a player from real-time match data.

  Example data shape:
  %{
    "abilities" => [5082, 5083, 5084, 5085, 6405, 6029, 6028, 5928, 6004, 6408, 6037, 6861],
    "accountid" => 178_366_364,
    "assists_count" => 9,
    "death_count" => 3,
    "denies_count" => 13,
    "gold" => 2192,
    "heroid" => 15,
    "items" => [63, 75, 75, 36, 100, 116, 0, 0, 0],
    "kill_count" => 8,
    "level" => 19,
    "lh_count" => 170,
    "name" => "Dead Calm",
    "net_worth" => 11862,
    "playerid" => 0,
    "team" => 2,
    "x" => 0.22221094369888306,
    "y" => -0.3521626889705658
  }

  """

  use Ecto.Schema

  import Ecto.Changeset

  alias __MODULE__

  @type t() :: %Player{}

  @required_params ~w(account_id hero_id name x y)a
  @rename_params [{"heroid", "hero_id"}, {"accountid", "account_id"}]

  @primary_key {:account_id, :id, autogenerate: false}
  embedded_schema do
    field :hero_id, :integer
    field :name, :string
    field :x, :float
    field :y, :float
  end

  @spec new(map() | list(map())) :: {:ok, Player.t()} | {:error, String.t()}
  def new(params) when is_map(params) do
    params
    |> rename_params()
    |> cast()
    |> apply_action(:insert)
  end

  def new(param_list) when is_list(param_list) do
    result =
      Enum.reduce_while(param_list, [], fn params, acc ->
        case new(params) do
          {:ok, player} -> {:cont, [player | acc]}
          {:error, message} -> {:halt, {:error, message}}
        end
      end)

    case result do
      {:error, _message} -> result
      players -> {:ok, players}
    end
  end

  defp rename_params(params) do
    Enum.reduce(@rename_params, params, fn {old, new}, acc ->
      acc
      |> Map.get(old)
      |> (&Map.put(acc, new, &1)).()
    end)
  end

  defp cast(params) do
    cast(%Player{}, params, @required_params)
  end
end
