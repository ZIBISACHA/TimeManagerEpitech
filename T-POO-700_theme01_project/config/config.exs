# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :timeManager,
  ecto_repos: [TimeManager.Repo]

# Configures the endpoint
config :timeManager, TimeManagerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eOK9ksLos+qzKeKw44JBZqeOuyZJyFo+9x94i2Q8hyu/rI4Xzcohh7Lm5PZAnFwC",
  render_errors: [view: TimeManagerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: TimeManager.PubSub,
  live_view: [signing_salt: "iiOgQwoB"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# Guardian config
config :timeManager, TimeManager.Guardian,
       issuer: "timeManager",
       ttl: { 30, :days },
       secret_key: "mkykeBPHsJupBGe0OXAjd9CK8frVfl3SxitLa2yZF0zgdfnYfaHqOfzNOVHpeBv/"
