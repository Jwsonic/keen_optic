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
      <%= for player <- @match.radiant.players  do %>
        <span class="radiant circle" style="top: <%= to_percent(player.y) %>%; left: <%= to_percent(player.x) %>%;"></span>
      <% end %>

      <%= for player <- @match.dire.players do %>
        <span class="dire circle" style="top: <%= to_percent(player.y) %>%; left: <%= to_percent(player.x) %>%;"></span>
      <% end %>
    </div>
    """
  end

  defp to_percent(num) do
    50 + num * 50
  end

  defp x_percent(num) when num < 0 do
    50 + abs(num) * 50
  end

  defp x_percent(num) do
    abs(num) * 50
  end

  defp y_percent(num) do
    50 + num * 50
  end

  def mount(params, _session, socket) do
    match_id = extract_id!(params)

    MatchWatcher.subscribe_match(match_id)

    match =
      case MatchWatcher.get_match(match_id) do
        :no_match -> %{radiant: %{players: []}}
        {:ok, match} -> match
      end

    {:ok, assign(socket, :match, match)}
  end

  # Genserver callbacks

  def handle_info({:match_update, match}, socket) do
    {:noreply, assign(socket, :match, match)}
  end

  defp extract_id!(%{"id" => id}) when is_bitstring(id) do
    case Integer.parse(id) do
      {id, _rest} ->
        id

      :error ->
        Logger.error("Got params with a non-int id #{inspect(id)}")

        GenServer.stop(self())
    end
  end

  defp extract_id!(%{"id" => id}) when is_integer(id) do
    id
  end

  defp extract_id!(params) do
    Logger.error("Got params with no match id #{inspect(params)}")

    GenServer.stop(self())
  end
end
