import Config

config :dxcworld, Dxcworld.Repo,
  database: Path.expand("../dxcworld_test.db", Path.dirname(__ENV__.file)),
  pool_size: 5,
  pool: Ecto.Adapters.SQL.Sandbox
