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
    <div class="mini-map-container">
      <img class="mini-map" src="/images/minimap.png" />

      <%= for player <- @match.radiant.players  do %>
        <img
        src="<%= player.hero.image_url %>"
        class="circle"
        style="bottom: <%= to_percent(player.y) %>%; right: <%= to_percent(player.x) %>%;"/>
      <% end %>

      <%= for player <- @match.dire.players do %>
        <img
        src="<%= player.hero.image_url %>"
        class="circle"
        style="bottom: <%= to_percent(player.y) %>%; right: <%= to_percent(player.x) %>%;"/>
      <% end %>
    </div>
    """
  end

  defp to_percent(num) do
    Float.round(50 + num * 50, 2)
  end

  def mount(params, _session, socket) do
    match_id = extract_id!(params)

    MatchWatcher.subscribe_match(match_id)

    match =
      case MatchWatcher.get_match(match_id) do
        :no_match -> %{radiant: %{players: []}, dire: %{players: []}}
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
