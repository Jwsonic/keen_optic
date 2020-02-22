defmodule KeenOptic.MatchWatcher.Worker do
  @moduledoc """
  `Worker` is a `GenServer` that watches, stores, and notifies other processes about specific match data.
  """
  use GenServer

  require Logger

  alias KeenOptic.Dota
  alias KeenOptic.MatchWatcher.Registry, as: MWRegistry
  alias KeenOptic.MatchWatcher.Supervisor, as: MWSupervisor
  alias Phoenix.PubSub

  @type match_id_type() :: non_neg_integer()

  @ets_table :live_matches

  @fetch_interval 5_000

  @match_topic_prefix "match"

  # Client methods

  @spec start_link(match_id_type()) :: GenServer.on_start()
  def start_link(match_id) do
    GenServer.start_link(__MODULE__, match_id, name: MWRegistry.via_tuple(match_id))
  end

  # Genserver callbacks

  @impl true
  def init(match_id) do
    Logger.info("Starting worker for match #{match_id}")

    schedule_fetch()

    {:ok, %{match_id: match_id}}
  end

  @impl true
  def handle_info(:fetch, %{match_id: match_id}) do
    Logger.info("Fetching match #{match_id}")

    # TODO: actually fetch match info here

    schedule_fetch()

    {:noreply, state}
  end

  @doc """
  Subscribes a process to receive updates about a match.
  May also start a worker to watch the match if there isn't one already started.
  """
  @spec subscribe_match(match_id_type()) :: :ok | {:error, term()}
  def subscribe_match(match_id) do
    maybe_start_worker(match)

    match_id
    |> build_topic()
    |> subscribe()
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

  defp schedule_fetch do
    Process.send_after(self(), :fetch, @fetch_interval)
  end

  defp subscribe(topic) do
    PubSub.subscribe(KeenOptic.PubSub, topic)
  end
end
