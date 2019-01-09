use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bookingz, BookingzWeb.Endpoint,
http: [port: 4001],
server: true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :bookingz, Bookingz.Repo,
  username: "postgres",
  password: "postgres",
  database: "bookingz_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

  config :hound, driver: "chrome_driver"
  config :rentit, sql_sandbox: true
