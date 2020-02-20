defmodule KeenOpticWeb.LiveView.LiveGamesList do
  use Phoenix.LiveView

  alias KeenOptic.GameListWatcher

  # LiveView callbacks

  def render(assigns) do
    ~L"""
    Current games:
    <ul>
      <%= for game <- @games do %>
        <%= live_patch to: Routes.live_path(@socket, LiveMatch, %{id: game.server_steam_id}), replace: false do %>
          <li>spectators: <%= game.spectators %>, mmr: <%= game.average_mmr %></li>
        <% end %>
      <% end %>
    </ul>
    """
  end

  def mount(_params, _session, socket) do
    games =
      case GameListWatcher.live_games() do
        {:ok, games} -> games
        _ -> []
      end

    GameListWatcher.subscribe_live_games()

    {:ok, assign(socket, :games, games)}
  end

  # Genserver callbacks
  def handle_info({:live_games, games}, socket) do
    {:noreply, assign(socket, :games, games)}
  end
end
