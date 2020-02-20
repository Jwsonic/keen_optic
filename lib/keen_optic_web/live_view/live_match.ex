defmodule KeenOpticWeb.LiveView.LiveMatch do
  use Phoenix.LiveView

  alias KeenOptic.GameListWatcher

  require Logger

  # LiveView callbacks

  def render(assigns) do
    ~L"""
    Game data
    """
  end

  def mount(_params, _session, socket) do
    # Game fetch and loading state goes here

    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    params |> inspect() |> Logger.info()
    {:noreply, socket}
  end

  # Genserver callbacks
  # def handle_info({:live_games, games}, socket) do
  #   {:noreply, assign(socket, :games, games)}
  # end
end
