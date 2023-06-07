defmodule DxcworldTest do
  use ExUnit.Case
  doctest Dxcworld

  setup do
    %{iac: <<255, 240, 239>>, clean_1: <<50, 45, 91, 116>>, clean_2: <<32, 88>>}
  end

  describe "chunkify/1" do
    alias Dxcworld.Mud.Telnet

    test "returns a good one", %{clean_1: clean_1} = _context do
      assert {^clean_1, :none} = Telnet.chunkify(clean_1)
    end
  end
end
