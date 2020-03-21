defmodule KeenOpticWeb.Router do
  use KeenOpticWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {KeenOpticWeb.LayoutView, :app}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KeenOpticWeb do
    pipe_through :browser

    live "/", LiveView.MatchesList
    live "/match", LiveView.Match
  end

  # Other scopes may use custom stacks.
  # scope "/api", KeenOpticWeb do
  #   pipe_through :api
  # end
end
