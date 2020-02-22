# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :keen_optic,
  ecto_repos: [KeenOptic.Repo]

# Configures the endpoint
config :keen_optic, KeenOpticWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yhoMjsKhFitgzGMm+CDT3BC6ywF53+Hnq755XgO8/4e+kLClCx69MxzZMU4n8V0f",
  render_errors: [view: KeenOpticWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: KeenOptic.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id, :match_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
