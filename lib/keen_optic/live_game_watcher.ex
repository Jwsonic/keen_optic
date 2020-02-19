defmodule KeenOptic.LiveGameWatcher do
  @moduledoc """
  LiveGameWatcher is a `GenServer` that fetches, stores, and notifies clients about new game data.
  """
  use GenServer

  require Logger

  alias KeenOptic.Dota

  @ets_table :live_games
  @games_key :games
  @fetch_interval 1_000

  @impl true
  def init(_opt) do
    @ets_table = :ets.new(@ets_table, [:set, :protected, :named_table])

    schedule_fetch()

    {:ok, nil}
  end

  @impl true
  def handle_info(:fetch, state) do
    update_games()

    notify_others()

    schedule_fetch()

    {:noreply, state}
  end

  # Client methods

  def start_link() do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @spec live_games() :: {:ok, list(KeenOptic.Dota.LiveGame.t())} | {:error, String.t()}
  def live_games do
    case :ets.lookup(@ets_table, @games_key) do
      [{@games_key, games}] -> {:ok, games}
      [] -> {:error, "No live games!"}
    end
  end

  # Private methods

  defp schedule_fetch do
    Process.send_after(self(), :fetch, @fetch_interval)
  end

  defp update_games do
    case Dota.live_games() do
      {:ok, games} -> :ets.insert(@ets_table, {@games_key, games})
      {:error, message} -> Logger.error("Fetch games call failed with #{inspect(message)}")
    end
  end

  defp notify_others do
  end
end
