defmodule KeenOpticWeb.LiveView.Match.PlayerComponent do
  use Phoenix.LiveComponent

  require Logger

  def render(assigns) do
    ~L"""
    <img
      src="<%= @player.hero.image_url %>"
      class="hero"
      style="bottom: <%= @player.bottom %>%; left: <%= @player.left %>%;"
    />
    """
  end
end
