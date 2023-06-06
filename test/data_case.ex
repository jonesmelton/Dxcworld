defmodule Dxcworld.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Dxcworld.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Dxcworld.DataCase
    end
  end

  setup do
    pid = Ecto.Adapters.SQL.Sandbox.start_owner!(Dxcworld.Repo, shared: false)
    on_exit(fn -> Ecto.Adapters.SQL.Sandbox.stop_owner(pid) end)
  end
end
