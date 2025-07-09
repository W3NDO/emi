import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :emi_web, EmiWebWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "PfRgC/233FR9GY1qBW5/Z1apnhIh/WovZ9OvZlJ0twGbnXzY0suqEJ1+9RrcqbSt",
  server: false

# In test we don't send emails
config :emi_web, EmiWeb.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
