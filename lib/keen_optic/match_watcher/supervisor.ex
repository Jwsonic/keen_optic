defmodule KeenOptic.MatchWatcher.Supervisor do
  @moduledoc """
  A `DynamicSupervisor` for the `MatchWatcher` module.
  """
  use DynamicSupervisor

  # Client methods

  @doc """
  Start a child watching a match with the given id. Workers are transient, meaning they
  will only be restarted if the exist abnormally.
  """
  @spec start_child(non_neg_integer()) :: DynamicSupervisor.on_start_child()
  def start_child(match_id) do
    DynamicSupervisor.start_child(
      __MODULE__,
      %{
        id: KeenOptic.MatchWatcher.Worker,
        start: {KeenOptic.MatchWatcher.Worker, :start_link, [match_id]},
        restart: :transient
      }
    )
  end

  def start_link(_arg) do
    DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  # DynamicSupervisor callbacks

  @impl true
  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
