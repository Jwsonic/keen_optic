defmodule KeenOptic.MatchWatcher.Registry do
  @name KeenOptic.MatchWatcher.Registry

  def start_link do
    Registry.start_link(keys: :unique, name: @name)
  end

  def subscribe_match(id) do
    case Registry.lookup(@name, id) do
      # create stuff here
      [] -> nil
      # add people here
      [_contents] -> nil
    end
  end

  defp key(id) do
  end
end
