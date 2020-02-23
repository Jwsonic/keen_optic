defmodule KeenOpticWeb.LiveView.Match do
  @moduledoc """
  Match is a `Phoenix.LiveView` process that subscribes to and displays data about a currently live match.
  """
  use Phoenix.LiveView

  require Logger

  alias KeenOptic.MatchWatcher.Worker, as: MatchWatcher
  alias KeenOpticWeb.Router.Helpers, as: Routes

  # LiveView callbacks

  def render(assigns) do
    ~L"""
    <div class="mini-map-container">
      <img class="mini-map" src="<%= Routes.static_path(KeenOpticWeb.Endpoint, "/images/minimap.png") %>" />
      <%= for player <- @match.radiant.players do %>
        <span style="top=<%= to_percent(player.x) %>%; left=<%= to_percent(player.y) %>%;"><%= player.name %></span>
      <% end %>
    </div>
    """
  end

  defp to_percent(num) when num < 0 do
    50 + abs(num) * 50
  end

  defp to_percent(num) do
    abs(num) * 50
  end

  def mount(_params, _session, socket) do
    # Game fetch and loading state goes here

    {:ok, assign(socket, :match, %{radiant: %{players: []}})}
  end

  def handle_params(params, _url, socket) do
    case extract_id(params) do
      :error ->
        GenServer.stop(self())

      id ->
        Logger.info("Watching match #{id}.")
        MatchWatcher.subscribe_match(id)
    end

    {:noreply, socket}
  end

  # Genserver callbacks

  def handle_info({:match_update, match}, socket) do
    {:noreply, assign(socket, :match, match)}
  end

  defp extract_id(%{"id" => id}) when is_bitstring(id) do
    case Integer.parse(id) do
      {id, _rest} ->
        id

      :error ->
        Logger.error("Got params with a non-int id #{inspect(id)}")

        :error
    end
  end

  defp extract_id(%{"id" => id}) when is_integer(id) do
    id
  end

  defp extract_id(params) do
    Logger.error("Got params with no match id #{inspect(params)}")

    :error
  end
end
