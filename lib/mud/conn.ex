defmodule Dxcworld.Mud.Conn do
  @moduledoc """
  Maintains websocket connection to the mud,
  sending and receiving data.
  """

  @doc """
  Agent for mud connection.
  Its state is a that holds the socket connection.
  """
  use GenServer
  require Logger

  @host {82, 68, 167, 69}
  @port 4242

  def com(command) do
    GenServer.cast(:mud_socket, {:message, command <> "\r\n"})
    :noreply
  end

  def start_link(_arg) do
    GenServer.start_link(__MODULE__, %{socket: nil}, name: :mud_socket)
  end

  @impl true
  def init(state) do
    send(self(), :connect)
    {:ok, state}
  end

  @impl true
  @doc "Initializes the socket connection."
  def handle_info(:connect, state) do
    if Mix.env() == :test do
      Logger.info("not connecting to telnet socket bc of :env")
    else
      Logger.info("connecting to #{:inet.ntoa(@host)}:#{@port}")

      case :gen_tcp.connect(@host, @port, [:binary, active: true, packet: 0]) do
        {:ok, socket} -> {:noreply, %{state | socket: socket}}
        {:error, reason} -> terminate(reason, state)
      end
    end

    {:noreply, state}
  end

  @impl true
  def handle_info({:tcp, _socket, frame}, state) do
    GenServer.cast(:telnet_processor, {:new_frame, frame})
    Logger.info("new telnet frame received")
    {:noreply, state}
  end

  @impl true
  def handle_info({:tcp_error, _pl}, state) do
    terminate("socket error", state)
  end

  @impl true
  def handle_info({:tcp_closed, _pl}, state) do
    terminate("closed by host", state)
  end

  @impl true
  @doc "Sends message through socket to mud."
  def handle_cast({_msg, message}, %{socket: socket} = state) do
    Logger.info("sending command: #{message}")

    with :ok <- :gen_tcp.send(socket, message) do
      Logger.info("send :ok")
    end

    {:noreply, state}
  end

  @impl true
  def terminate(reason, state) do
    Logger.info("disconnected: #{reason}")
    {:stop, :normal, state}
  end
end
