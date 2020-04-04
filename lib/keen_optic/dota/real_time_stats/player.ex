defmodule KeenOptic.Dota.RealTimeStats.Player do
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
  use KeenOptic.ExternalData

  alias KeenOptic.Dota.Hero

  @primary_key {:account_id, :id, autogenerate: false}
  embedded_schema do
    field :name, :string
    field :x, :float
    field :y, :float
    field :bottom, :float
    field :left, :float

    embeds_one :hero, Hero
  end

  @accountid_key "accountid"
  @account_id_key "account_id"
  @x_key "x"
  @left_key "left"
  @y_key "y"
  @bottom_key "bottom"

  @impl true
  def coerce_params(params) do
    # We pre-compute some values needed by the view at decode time so LiveView processes won't duplicate work.
    with {:ok, account_id} <- extract_param(params, @accountid_key),
         {:ok, x} <- extract_param(params, @x_key),
         {:ok, left} <- to_percent(x),
         {:ok, y} <- extract_param(params, @y_key),
         {:ok, bottom} <- to_percent(y) do
      new_params =
        params
        |> Map.put(@account_id_key, account_id)
        |> Map.put(@left_key, left)
        |> Map.put(@bottom_key, bottom)

      {:ok, new_params}
    else
      {:error, _messsage} = error -> error
    end
  end

  @impl true
  def extra_changes(changeset, params) do
    hero = params |> Map.get("heroid") |> Hero.hero()

    put_embed(changeset, :hero, hero)
  end

  defp extract_param(params, param) do
    case Map.get(params, param) do
      nil -> {:error, "Missing key '#{param}'."}
      result -> {:ok, result}
    end
  end

  defp to_percent(num) when is_number(num) do
    percent = num |> Kernel.+(0.5) |> Kernel.*(100.0) |> Float.round(2)

    {:ok, percent}
  end

  defp to_percent(num) do
    {:error, "Expected float, got #{inspect(num)} instead."}
  end
end
