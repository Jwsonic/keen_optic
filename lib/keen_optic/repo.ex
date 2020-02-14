defmodule KeenOptic.Repo do
  use Ecto.Repo,
    otp_app: :keen_optic,
    adapter: Ecto.Adapters.Postgres
end
