defmodule Webtestapp.Repo do
  use Ecto.Repo,
    otp_app: :webtestapp,
    adapter: Ecto.Adapters.Postgres
end
