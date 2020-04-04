defmodule KeenOptic.OpenDota.ProPlayer do
  use KeenOptic.ExternalData

  @account_id {:account_id, :id, autogenerate: false}
  embedded_schema do
    field :name, :string
    field :team_tag, :string
  end

  def full_name(%ProPlayer{name: name, team_tag: team_tag}) do
    "#{team_tag}.#{name}"
  end
end
