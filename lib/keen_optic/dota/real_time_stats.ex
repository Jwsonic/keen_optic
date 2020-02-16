defmodule KeenOptic.Dota.RealTimeStats do
  use TypedStruct

  alias __MODULE__
  alias KeenOptic.Dota.Match

  typedstruct do
    field :match, Match.t(), enforce: true
    field :teams, list(), enforce: true
    field :buildings, list(), enforce: true
    field :graph_data, Match.t(), enforce: true
    field :delta_frame, boolean(), enforce: true
  end

  @spec from_map(map()) :: {:ok, RealTimeStats.t()} | {:error, String.t()}
  def from_map(%{
        "match" => match,
        "teams" => teams,
        "buildings" => buildings,
        "graph_data" => graph_data
        # "delta_frame" => delta_frame
      }) do
    with {:ok, match} <- Match.from_map(match) do
      {:ok,
       %RealTimeStats{
         match: match,
         teams: teams,
         buildings: buildings,
         graph_data: graph_data,
         delta_frame: false
       }}
    end
  end
end
