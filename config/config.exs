# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :barcode_service,
  ecto_repos: [BarcodeService.Repo]

# Configures the endpoint
config :barcode_service, BarcodeServiceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HpBkh/k6+tn4mvdxFT90fQFaTTmivy5aC/2gMunqrIzcDL3JGAcJjfnjaF5j2Nvl",
  render_errors: [view: BarcodeServiceWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BarcodeService.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
