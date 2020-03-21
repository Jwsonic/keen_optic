defmodule KeenOpticWeb.LiveView.MatchesList do
  @moduledoc """
  Match is a `Phoenix.LiveView` process that subscribes to and displays data about the list of currently live matches.
  """

  use Phoenix.LiveView

  alias KeenOptic.LiveGamesWatcher.Worker, as: LiveGamesWatcher
  alias KeenOpticWeb.LiveView.Match
  alias KeenOpticWeb.Router.Helpers, as: Routes

  # LiveView callbacks

  def render(assigns) do
    ~L"""
    Current games:
    <ul>
      <%= for game <- @games do %>
        <%= live_patch to: Routes.live_path(@socket, Match, %{id: game.server_steam_id}), replace: false do %>
          <li>spectators: <%= game.spectators %>, mmr: <%= game.average_mmr %></li>
        <% end %>
      <% end %>
    </ul>
    """
  end

  def mount(_params, _session, socket) do
    games =
      case LiveGamesWatcher.live_games() do
        {:ok, games} -> games
        _ -> []
      end

    LiveGamesWatcher.subscribe_live_games()

    {:ok, assign(socket, :games, games)}
  end

  # Genserver callbacks

  def handle_info({:live_games, games}, socket) do
    {:noreply, assign(socket, :games, games)}
  end
end
