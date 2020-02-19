defmodule KeenOptic.GameListWatcher do
  @moduledoc """
  GameListWatcher is a `GenServer` that fetches, stores, and notifies clients about new game data.
  """
  use GenServer

  require Logger

  alias KeenOptic.Dota
  alias Phoenix.PubSub

  @ets_table :live_games
  @ets_key :games

  @fetch_interval 1_000

  @live_games_topic "live_games"
  @live_games_key :live_games

  # Genserver callbacks

  @impl true
  def init(_opt) do
    :ets.new(@ets_table, [:set, :protected, :named_table])

    schedule_fetch()

    {:ok, nil}
  end

  @impl true
  def handle_info(:fetch, state) do
    update_games()

    schedule_fetch()

    {:noreply, state}
  end

  # Client methods

  def start_link(_opt) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @spec live_games() :: {:ok, list(KeenOptic.Dota.LiveGame.t())} | {:error, String.t()}
  def live_games do
    case :ets.lookup(@ets_table, @ets_key) do
      [{@ets_key, games}] -> {:ok, games}
      [] -> {:error, "No live games!"}
    end
  end

  @spec subscribe_live_games() :: :ok | {:error, term()}
  def subscribe_live_games do
    PubSub.subscribe(KeenOptic.PubSub, @live_games_topic)
  end

  # Private methods

  defp schedule_fetch do
    Process.send_after(self(), :fetch, @fetch_interval)
  end

  defp update_games do
    case Dota.live_games() do
      {:ok, games} ->
        :ets.insert(@ets_table, {@ets_key, games})

        PubSub.broadcast(KeenOptic.PubSub, @live_games_topic, {@live_games_key, games})

      {:error, message} ->
        Logger.error("Fetch games call failed with #{inspect(message)}")
    end
  end
end
