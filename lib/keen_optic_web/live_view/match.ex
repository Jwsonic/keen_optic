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
    <%= @match |> Map.get(:teams) |> inspect() %>
    """
  end

  def mount(_params, _session, socket) do
    # Game fetch and loading state goes here

    {:ok, assign(socket, :match, %{})}
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
