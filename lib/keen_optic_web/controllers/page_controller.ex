defmodule KeenOpticWeb.PageController do
  use KeenOpticWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
