defmodule KeenOptic.Dota.FetchRealtimeStats do
  use Exop.Operation

  alias KeenOptic.Dota.Api

  parameter(:server_steam_id, type: :integer, numericality: %{greater_than: 0})

  def process(params) do
    Api.real_time_stats(params.server_steam_id)
  end
end
