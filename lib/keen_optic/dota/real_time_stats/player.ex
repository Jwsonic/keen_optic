defmodule KeenOptic.RealTimeStats.Player do
  use TypedStruct

  alias __MODULE__

  #       %{
  #         "abilities" => [5082, 5083, 5084, 5085, 6405, 6029, 6028, 5928, 6004, 6408, 6037, 6861],
  #         "accountid" => 178_366_364,
  #         "assists_count" => 9,
  #         "death_count" => 3,
  #         "denies_count" => 13,
  #         "gold" => 2192,
  #         "heroid" => 15,
  #         "items" => [63, 75, 75, 36, 100, 116, 0, 0, 0],
  #         "kill_count" => 8,
  #         "level" => 19,
  #         "lh_count" => 170,
  #         "name" => "Dead Calm",
  #         "net_worth" => 11862,
  #         "playerid" => 0,
  #         "team" => 2,
  #         "x" => 0.22221094369888306,
  #         "y" => -0.3521626889705658
  #       },

  typedstruct do
    field :accountid, non_neg_integer(), enforce: true
    field :hero_id, non_neg_integer(), enforce: true
    field :name, String.t(), enforce: true
    field :x, float(), enforce: true
    field :y, float(), enforce: true
  end

  @spec from_list(list(map())) :: {:ok, list(Player.t())} | {:error, String.t()}
  def from_list(list) do
    results =
      list
      |> Enum.map(&from_map/1)
      |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))

    case results[:error] do
      nil -> {:ok, results[:ok]}
      [error | _rest] -> error
    end
  end

  @spec from_map(map()) :: {:ok, Player.t()} | {:error, String.t()}
  def from_map(%{
        "accountid" => accountid,
        "heroid" => hero_id,
        "name" => name,
        "x" => x,
        "y" => y
      }) do
    {:ok, %Player{accountid: accountid, hero_id: hero_id, name: name, x: x, y: y}}
  end

  def from_map(data) do
    {:error, "Missing data for player: #{inspect(data)}."}
  end
end
