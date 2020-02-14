use Mix.Config

# Configure your database
config :keen_optic, KeenOptic.Repo,
  username: "postgres",
  password: "postgres",
  database: "keen_optic_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :keen_optic, KeenOpticWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
