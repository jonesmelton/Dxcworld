defmodule Dxcworld.Mud.Telnet do
  @moduledoc """
  Consts and functions for cleaning & tokenizing telnet
  data. The line between this and parsing is blurry but I
  intend to have most of the data extraction happen later.
  """

  @typedoc "`char_code` is a particle of telnet, ints 0-255."
  @type char_code :: byte

  @typedoc ~S"""
  `frame` is a bitstring of char_codes. Possibly an encoding of a
  valid string, but only if it doesn't include telnet
  command sequences.
  """
  @type frame :: <<_::8, _::_*256>>

  @typedoc """
  `current` represents the progress of chunking a telnet
  frame. The first member is a bitstring of either a valid
  string or a telnet command. The second member is the
  remainder of the frame, or nothing if it is fully
  processed.
  """
  @type current :: {fragment :: nonempty_charlist, rest :: frame | :done}

  @doc """
  Splits a frame into meaningful fragments and
  dispatches them to the parser. Pattern matching on
  the bitstring is awkward but it should be efficient
  and avoids having to stream it.
  """
  @spec chunkify(frame) :: current
  def chunkify(frame) do
    case :binary.match(frame, <<255>>) do
      :nomatch ->
        {:text, frame}

      {hd_width, _l} ->
        <<_data::binary-size(hd_width), command::binary>> = frame
        {:command, command}
    end
  end

  @doc """
  Agent for processing telnet data.
  Its state is a bitstring of unprocessed data.
  """
  use GenServer
  require Logger

  def start_link(_arg) do
    GenServer.start_link(__MODULE__, %{backlog: <<>>}, name: :telnet_processor)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  @doc "Pushes new mud data onto backlog."
  def handle_cast({:new_frame, frame}, %{backlog: backlog} = _state) do
    Logger.info("received new telnet frame")
    {:noreply, %{backlog: backlog <> frame}}
  end
end
