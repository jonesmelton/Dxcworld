defmodule Dxcworld.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Dxcworld.Repo,
    ]

    opts = [strategy: :one_for_one, name: Dxcworld.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(_changed, _new, _removed) do
    :ok
  end
end
