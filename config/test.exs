import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :form_validator, FormValidator.Repo,
  username: "postgres",
  password: System.get_env("DB_PASSWORD", "postgres"),
  hostname: "localhost",
  database: "form_validator_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :form_validator, FormValidatorWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "PV3N9TEt5HiRHt4jmMJw5LWN4Pn1HrEvCBresNmcBpNOjbPBDOZk7t/RVpRYz4qX",
  server: false

# In test we don't send emails.
config :form_validator, FormValidator.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
