require Logger
defmodule TimeManagerWeb.WorkingtimeController do
  use TimeManagerWeb, :controller

  alias TimeManager.Workingtimes
  alias TimeManager.Workingtimes.Workingtime

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Workingtimes.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"workingtime" => workingtime_params}) do
    with {:ok, %Workingtime{} = workingtime} <- Workingtimes.create_workingtime(workingtime_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
      |> render("show.json", workingtime: workingtime)
    end
  end

  def show(conn, %{"userID" => userID, "id" => id}) do
    workingtime = Workingtimes.get_workingtime_by_user!(id, userID)
    render(conn, "show.json", workingtime: workingtime)
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Workingtimes.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Workingtimes.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Workingtimes.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Workingtimes.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end

  def showByUser(conn, %{"userID" => user, "start" => start, "end" => endOfWorktime} = params) do
    Logger.warn(Timex.parse!(start, "{YYYY}-{0M}-{0D} {h24}:{m}:{s}"))
    workingtime = Workingtimes.getWorkingtimeByUser(user, Timex.parse!(start, "{YYYY}-{0M}-{0D} {h24}:{m}:{s}"), Timex.parse!(endOfWorktime, "{YYYY}-{0M}-{0D} {h24}:{m}:{s}"))
    render(conn, "index.json", workingtimes: workingtime)
  end

  def createWorkingtimeByUser(conn, %{"userID" => user_id, "workingtime" => workingtime_params}) do
    workingtime_params = Map.put(workingtime_params, "users_id", user_id)
    Logger.info user_id
    with {:ok, %Workingtime{} = workingtime} <- Workingtimes.create_workingtime(workingtime_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :showByUser, workingtime))
      |> render("show.json", workingtime: workingtime)
    end
  end
end
