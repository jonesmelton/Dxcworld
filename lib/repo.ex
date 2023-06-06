defmodule Dxcworld.Repo do
  use Ecto.Repo,
    otp_app: :dxcworld,
    adapter: Ecto.Adapters.SQLite3
end
