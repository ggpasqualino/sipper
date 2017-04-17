# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for third-
# party users, it should be done in your mix.exs file.

# Sample configuration:
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]

# NOTE: If you change this config, you need to recompile, by runnning "mix escript.build".
config :sipper,
  config_file: ".sipper",
  feed_cache: [file: "sipper.cache", ttl_seconds: 60 * 10],
  feed_client: Sipper.DpdCartClient,
  feed_timeout_ms: 100_000,  # The default 5000 will time out sometimes.
  feed_parser: Sipper.FeedParser,
  file_client: Sipper.DpdCartClient

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"
