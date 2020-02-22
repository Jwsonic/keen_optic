defmodule KeenOpticWeb.LiveView.Match do
  @moduledoc """
  Match is a `Phoenix.LiveView` process that subscribes to and displays data about a currently live match.
  """
  use Phoenix.LiveView

  require Logger

  # LiveView callbacks

  def render(assigns) do
    ~L"""
    Game data
    """
  end

  def mount(%{"id" => id}, _session, socket) do
    # Game fetch and loading state goes here

    Logger.info("mount")

    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    params |> inspect() |> Logger.info()
    {:noreply, socket}
  end
end
