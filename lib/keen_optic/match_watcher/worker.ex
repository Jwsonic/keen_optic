defmodule KeenOptic.MatchWatcher.Worker do
  @moduledoc """
  `Worker` is a `GenServer` that watches, stores, and notifies other processes about specific match data.
  """
  use GenServer

  require Logger

  alias KeenOptic.Dota
  alias KeenOptic.Dota.RealTimeStats
  alias KeenOptic.MatchWatcher.Registry, as: MWRegistry
  alias KeenOptic.MatchWatcher.Supervisor, as: MWSupervisor
  alias Phoenix.PubSub

  @update_interval 5_000

  @match_topic_prefix "match"
  @match_key :match_update

  @ets_table :matches

  # Client methods

  @spec start_link(non_neg_integer()) :: GenServer.on_start()
  def start_link(match_id) do
    GenServer.start_link(__MODULE__, match_id, name: MWRegistry.via_tuple(match_id))
  end

  @doc """
  Returns a real time match data if we have any.
  """
  @spec get_match(non_neg_integer()) :: {:ok, RealTimeStats.t()} | :no_match
  def get_match(match_id) do
    maybe_start_worker(match_id)

    case :ets.lookup(@ets_table, match_id) do
      [{^match_id, match}] -> {:ok, match}
      [] -> :no_match
    end
  end

  @doc """
  Subscribes a process to receive updates about a match.
  May also start a worker to watch the match if there isn't one already started.
  """
  @spec subscribe_match(non_neg_integer()) :: :ok | {:error, term()}
  def subscribe_match(match_id) do
    maybe_start_worker(match_id)

    match_id
    |> build_topic()
    |> subscribe()
  end

  # Genserver callbacks

  @impl true
  def init(match_id) do
    Logger.metadata(match_id: match_id)
    Logger.info("Starting worker.")

    :ets.new(@ets_table, [:set, :protected, :named_table])

    schedule_update()

    {:ok, %{match_id: match_id}}
  end

  @impl true
  def handle_info(:update, %{match_id: match_id} = state) do
    case update_match(match_id) do
      :ok ->
        schedule_update()

        {:noreply, state}

      {:error, error} ->
        Logger.error("Received error: #{inspect(error)}")
        {:noreply, state}

      :stop ->
        {:stop, :normal, state}
    end
  end

  # Private methods

  defp build_topic(match_id) do
    "#{@match_topic_prefix}#{match_id}"
  end

  defp maybe_start_worker(match_id) do
    case MWRegistry.exists?(match_id) do
      false -> MWSupervisor.start_child(match_id)
      _ -> :ok
    end
  end

  defp schedule_update do
    Process.send_after(self(), :update, @update_interval)
  end

  defp subscribe(topic) do
    PubSub.subscribe(KeenOptic.PubSub, topic)
  end

  defp update_match(match_id) do
    Logger.info("Updating match data.")

    case Dota.real_time_stats(match_id) do
      {:ok, match} ->
        :ets.insert(@ets_table, {match_id, match})

        topic = build_topic(match_id)
        PubSub.broadcast(KeenOptic.PubSub, topic, {@match_key, match})

        :ok

      {:error, :no_match} ->
        Logger.error("No match with id #{match_id}.")

        :stop

      {:error, _error} = error ->
        error
    end
  end
end
