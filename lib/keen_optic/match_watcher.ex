defmodule KeenOptic.MatchWatcher do
  @moduledoc """
  GameListWatcher is a `GenServer` that fetches, stores, and notifies clients about new a specific live match.
  """
  use GenServer

  require Logger

  alias KeenOptic.Dota
  alias Phoenix.PubSub

  @ets_table :live_games
  @ets_key :games

  @fetch_interval 5_000

  @match_topic_prefix "match"
  @live_games_key :live_games

  # Genserver callbacks

  @impl true
  def init(_opt) do
    schedule_fetch()

    {:ok, nil}
  end

  @impl true
  def handle_info(:fetch, state) do
    schedule_fetch()

    {:noreply, state}
  end

  # Client methods

  def start_link(_opt) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @spec subscribe_match(non_neg_integer()) :: :ok | {:error, term()}
  def subscribe_match(id) do
    topic = "#{@match_topic_prefix}#{id}"
    PubSub.subscribe(KeenOptic.PubSub, topic)
  end

  # Private methods

  defp schedule_fetch do
    Process.send_after(self(), :fetch, @fetch_interval)
  end
end
