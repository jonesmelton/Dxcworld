import Config

config :dxcworld,
  ecto_repos: [Dxcworld.Repo]

config :logger, :console, format: "$time $metadata[$level] $message\n"

# must be last line
import_config "#{config_env()}.exs"
