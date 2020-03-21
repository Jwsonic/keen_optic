defmodule KeenOpticWeb.LiveView.Match.PlayerComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~L"""
    <img
      src="<%= @player.hero.image_url %>"
      class="circle"
      style="bottom: <%= to_percent(@player.y) %>%; right: <%= to_percent(@player.x) %>%;"/>
    """
  end

  defp to_percent(num) do
    Float.round(50 + num * 50, 2)
  end
end
