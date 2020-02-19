defmodule KeenOptic.GameListWatcher.Supervisor do
  @moduledoc """
  A `Supervisor` for the `GameListWatcher` module.
  """
  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    children = [
      KeenOptic.GameListWatcher
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
