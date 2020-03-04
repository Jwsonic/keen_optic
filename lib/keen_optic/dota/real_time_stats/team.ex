defmodule KeenOptic.RealTimeStats.Team do
  use TypedStruct

  alias __MODULE__
  alias KeenOptic.RealTimeStats.Player

  # Example data
  # [
  #   %{
  #     "net_worth" => 42876,
  #     "players" => [
  #     ],
  #     "score" => 37,
  #     "team_id" => 0,
  #     "team_logo" => 0,
  #     "team_logo_url" => "",
  #     "team_name" => "",
  #     "team_number" => 2,
  #     "team_tag" => ""
  #   },
  #   %{
  #     "net_worth" => 36609,
  #     "players" => [
  #     ],
  #     "score" => 22,
  #     "team_id" => 0,
  #     "team_logo" => 0,
  #     "team_logo_url" => "",
  #     "team_name" => "",
  #     "team_number" => 3,
  #     "team_tag" => ""
  #   }
  # ]

  typedstruct do
    field :net_worth, non_neg_integer(), enforce: true
    field :players, list(Player.t()), enforce: true
    field :score, non_neg_integer(), enforce: true
  end

  @spec from_map(map()) :: {:ok, Team.t()} | {:error, String.t()}
  def from_map(%{"net_worth" => net_worth, "players" => players, "score" => score}) do
    with {:ok, players} <- Player.new(players) do
      {:ok,
       %Team{
         net_worth: net_worth,
         players: players,
         score: score
       }}
    else
      error -> error
    end
  end
end
