defmodule KeenOpticWeb.LiveView.Match do
  @moduledoc """
  Match is a `Phoenix.LiveView` process that subscribes to and displays data about a currently live match.
  """
  use Phoenix.LiveView

  require Logger

  alias KeenOptic.MatchWatcher.Worker, as: MatchWatcher

  # LiveView callbacks

  def render(assigns) do
    ~L"""
    <%= inspect(@match) %>
    """
  end

  def mount(%{"id" => id}, _session, socket) do
    # Game fetch and loading state goes here

    MatchWatcher.subscribe_match(id)

    {:ok, assign(socket, :match, %{})}
  end

  def handle_params(params, _url, socket) do
    params |> inspect() |> Logger.info()
    {:noreply, socket}
  end

  # Genserver callbacks

  def handle_info({:match_update, match}, socket) do
    {:noreply, assign(socket, :match, match)}
  end
end
