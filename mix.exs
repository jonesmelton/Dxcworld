defmodule Dxcworld.MixProject do
  use Mix.Project

  def project do
    [
      app: :dxcworld,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Dxcworld.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.10"},
      {:ecto_sqlite3, ">= 0.0.0"},
      {:dialyxir, "~> 1.3", only: [:dev], runtime: false}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "ecto.migrate"],
      "ecto.reset": ["ecto.drop", "setup"]
    ]
  end
end
