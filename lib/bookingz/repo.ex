defmodule Bookingz.Repo do
  use Ecto.Repo,
    otp_app: :bookingz,
    adapter: Ecto.Adapters.Postgres
end
