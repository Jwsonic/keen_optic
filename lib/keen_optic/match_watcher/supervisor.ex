defmodule KeenOptic.MatchWatcher.Supervisor do
  @moduledoc """
  A `Supervisor` for the `MatchWatcher` module.
  """
  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    children = []

    Supervisor.init(children, strategy: :one_for_one)
  end

  def new_child(id) do
    Supervisor.start_link(
      KeenOptic.MatchWatcher,
      {:via, Registry, {KeenOptic.MatchWatcher.Registry, id}}
    )
  end
end
