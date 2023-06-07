import Config

config :dxcworld,
  ecto_repos: [Dxcworld.Repo]

config :logger, :console,
  level: :debug,
  format: "$time $message $metadata[$level] \n",
  metadata: [:error_code, :mfa]

# must be last line
import_config "#{config_env()}.exs"
