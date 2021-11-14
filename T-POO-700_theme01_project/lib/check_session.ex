defmodule TimeManager.CheckSession do
  @behaviour Plug
  require Logger
  import Plug.Conn
  alias TimeManager.Guardian

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    user = Guardian.Plug.current_resource(conn)
    Logger.info("Maybe he's connected ... or not!")

    if user do
      conn
    else
      conn
      |> send_resp(:unauthorized, "Login to proceed")
      # this one is important as this will "brake" processing
      |> halt()
    end
  end
end
