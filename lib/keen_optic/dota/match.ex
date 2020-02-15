defmodule KeenOptic.Dota.Match do
  use TypedStruct
  @before_compile ExternalData

  alias KeenOptic.Dota.Pick

  typedstruct do
    field :server_steam_id, non_neg_integer(), enforce: true
    field :matchid, non_neg_integer(), enforce: true
    field :timestamp, non_neg_integer(), enforce: true
    field :game_time, non_neg_integer(), enforce: true
    field :game_mode, non_neg_integer(), enforce: true
    field :league_id, non_neg_integer(), enforce: true
    field :league_node_id, non_neg_integer(), enforce: true
    field :game_state, non_neg_integer(), enforce: true
    field :picks, list(Pick.t()), enforce: true
    field :bans, list(map()), enforce: true
  end
end
