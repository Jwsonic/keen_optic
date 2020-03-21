defmodule KeenOpticWeb.LiveView.Match.PlayerComponent do
  use Phoenix.LiveComponent

  require Logger

  def render(assigns) do
    ~L"""
    <img
      src="<%= @player.hero.image_url %>"
      class="circle"
      style="top: <%= top_percent(@player) %>%; left: <%= to_percent(@player.x) %>%;"
    />
    """
  end

  defp top_percent(%{hero: %{name: name}, y: y}) do
    Logger.info(name)
    Logger.info("#{y}", label: :top)
    Float.round(50 + y * -50, 2)
  end

  defp to_percent(num) do
    Float.round(num * -100, 2)
  end
end
