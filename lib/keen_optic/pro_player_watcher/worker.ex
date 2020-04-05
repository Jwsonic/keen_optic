defmodule KeenOptic.ProPlayerWatcher.Worker do
  @moduledoc """

  """
  use GenServer

  alias KeenOptic.Dota.RealTimeStats.Player
  alias KeenOptic.OpenDota
  alias KeenOptic.OpenDota.ProPlayer

  require Logger

  @ets_table :pro_players
  # Hour in MS
  @update_interval 1_000 * 60 * 60

  # Client methods
  @spec start_link() :: GenServer.on_start()
  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @doc """
  Looks for the player's account id on a list of pro players. If the player is a pro player,
  their name is changed to their full professional name.
  """
  @spec maybe_rename_player(Player.t()) :: Player.t()
  def maybe_rename_player(%Player{account_id: account_id} = player) do
    case :ets.lookup(@ets_table, account_id) do
      [{^account_id, pro_player}] ->
        %{player | name: ProPlayer.full_name(pro_player)}

      [] ->
        player
    end
  end

  # GenServer callbacks
  @impl true
  def init(_opt) do
    :ets.new(@ets_table, [:set, :protected, :named_table])

    # Grab data right on boot
    update_players()

    schedule_update()

    {:ok, nil}
  end

  @impl true
  def handle_info(:update, state) do
    update_players()

    schedule_update()

    {:noreply, state}
  end

  defp update_players do
    case OpenDota.pro_players() do
      {:ok, players} -> Enum.each(players, &upsert_player/1)
      {:error, error} -> Logger.error("Error updating pro players #{error}.")
    end
  end

  defp schedule_update do
    Process.send_after(self(), :update, @update_interval)
  end

  defp upsert_player(%ProPlayer{account_id: account_id} = player) do
    :ets.insert(@ets_table, {account_id, player})
  end
end
