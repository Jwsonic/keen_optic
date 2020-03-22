defmodule KeenOptic.MatchWatcher.Registry do
  @moduledoc """
  `Registry` is a process registry that keeps track of match watching `Worker`s.
  """
  @name __MODULE__

  # Client methods

  @doc """
  Returns true if there is a process watching the match with the given id.
  Otherwise, it returns false.
  """
  @spec exists?(non_neg_integer()) :: boolean()
  def exists?(match_id) when is_integer(match_id) do
    case Registry.lookup(@name, match_id) do
      [] -> false
      _result -> true
    end
  end

  @doc """
  Return a "via tuple" that can be used to start a match watcher Worker linked to this Registry.
  """
  @spec via_tuple(non_neg_integer()) :: {:via, module(), {module(), non_neg_integer()}}
  def via_tuple(match_id) do
    {:via, Registry, {@name, match_id}}
  end

  def child_spec(_opts) do
    Registry.child_spec(keys: :unique, name: @name)
  end
end
