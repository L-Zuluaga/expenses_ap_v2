# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :expenses_app,
  ecto_repos: [ExpensesApp.Repo]

# Configures the endpoint
config :expenses_app, ExpensesAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2U6/DY6IozcfTGMcHNzjvhcrxmiLxZ8Bv0DGtu3pEc9aEbalKP11wPKaKAsYUpQ6",
  render_errors: [view: ExpensesAppWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ExpensesApp.PubSub,
  live_view: [signing_salt: "UXCB8skI"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
