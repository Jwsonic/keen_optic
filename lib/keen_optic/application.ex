defmodule KeenOptic.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children =
      [
        # Start the endpoint when the application starts
        KeenOpticWeb.Endpoint
      ] ++ env_children(Mix.env())

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KeenOptic.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    KeenOpticWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  # Don't start watchers in tests
  defp env_children(:test) do
    []
  end

  defp env_children(_dev_or_prod) do
    [
      KeenOptic.LiveGamesWatcher.Supervisor,
      KeenOptic.MatchWatcher.Supervisor,
      KeenOptic.MatchWatcher.Registry
    ]
  end
end
