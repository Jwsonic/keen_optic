defmodule KeenOpticWeb.LiveView.Match.PlayerComponent do
  use Phoenix.LiveComponent

  require Logger

  def render(assigns) do
    ~L"""
    <img
      src="<%= @player.hero.image_url %>"
      class="circle"
      style="bottom: <%= to_percent(@player.y) %>%; left: <%= to_percent(@player.x) %>%;"
    />
    """
  end

  defp to_percent(num) do
    num |> Kernel.+(0.5) |> Kernel.*(100.0) |> Float.round(2)
  end
end
