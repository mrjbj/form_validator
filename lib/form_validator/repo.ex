defmodule FormValidator.Repo do
  use AshPostgres.Repo, otp_app: :form_validator, adapter: Ecto.Adapters.Postgres
end
