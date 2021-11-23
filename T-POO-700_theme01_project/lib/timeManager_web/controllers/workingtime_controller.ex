require Logger

defmodule TimeManagerWeb.WorkingtimeController do
  use TimeManagerWeb, :controller
  import TimeManager.Authorization
  import Ecto.Query, warn: false

  alias TimeManager.Workingtimes
  alias TimeManager.Workingtimes.Workingtime
  alias TimeManager.Repo

  action_fallback(TimeManagerWeb.FallbackController)

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    role = user.role_id

    if can(role) |> read?(Workingtime) do
      workingtimes = Workingtimes.list_workingtimes()
      render(conn, "index.json", workingtimes: workingtimes)
    else
      conn
      |> Plug.Conn.halt()
    end
  end

  def create(conn, %{"workingtime" => workingtime_params}) do
    userTest = Guardian.Plug.current_resource(conn)
    roleTest = userTest.role_id
    Logger.info("Arcane")
    Logger.info(userTest)

    with {:ok, %Workingtime{} = workingtime} <-
           Workingtimes.create_workingtime(workingtime_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
      |> render("show.json", workingtime: workingtime)
    end
  end

  def get_workingtime!(id) do
    Repo.get!(Workingtime, id)
  end

  def get_workingtime_by_user2!(id) do
    query = from(w in Workingtime, where: w.users_id == ^id)
    Repo.all(query)
  end

  def show(conn, %{"userID" => userID, "id" => id}) do
    userTest = Guardian.Plug.current_resource(conn)
    a = get_workingtime!(id)
    Logger.info("NETFLIX")
    Logger.info(a)
    roleTest = userTest.role_id
    Logger.info(userTest.id)
    Logger.info(userTest)

    cond do
      roleTest == 1 ->
        workingtime = Workingtimes.get_workingtime_by_user!(id, userID)
        render(conn, "show.json", workingtime: workingtime)

      roleTest == 2 ->
        workingtime = Workingtimes.get_workingtime_by_user!(id, userID)
        render(conn, "show.json", workingtime: workingtime)

      roleTest == 3 ->
        workingtime = Workingtimes.get_workingtime_by_user!(id, userID)
        render(conn, "show.json", workingtime: workingtime)

      true ->
        conn |> Plug.Conn.halt()
    end
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    userTest = Guardian.Plug.current_resource(conn)
    roleTest = userTest.role_id

    cond do
      roleTest == 1 ->
        workingtime = Workingtimes.get_workingtime!(id)

        with {:ok, %Workingtime{} = workingtime} <-
               Workingtimes.update_workingtime(workingtime, workingtime_params) do
          render(conn, "show.json", workingtime: workingtime)
        end

      roleTest == 2 ->
        workingtime = Workingtimes.get_workingtime!(id)

        with {:ok, %Workingtime{} = workingtime} <-
               Workingtimes.update_workingtime(workingtime, workingtime_params) do
          render(conn, "show.json", workingtime: workingtime)
        end

      roleTest == 3 ->
        conn |> Plug.Conn.halt()

      true ->
        conn |> Plug.Conn.halt()
    end
  end

  def delete(conn, %{"id" => id}) do
    userTest = Guardian.Plug.current_resource(conn)
    roleTest = userTest.role_id

    cond do
      roleTest == 1 ->
        workingtime = Workingtimes.get_workingtime!(id)

        with {:ok, %Workingtime{}} <- Workingtimes.delete_workingtime(workingtime) do
          send_resp(conn, :no_content, "")
        end

      roleTest == 2 ->
        workingtime = Workingtimes.get_workingtime!(id)

        with {:ok, %Workingtime{}} <- Workingtimes.delete_workingtime(workingtime) do
          send_resp(conn, :no_content, "")
        end

      roleTest == 3 ->
        conn |> Plug.Conn.halt()

      true ->
        conn |> Plug.Conn.halt()
    end
  end

  def showByUser(conn, %{"userID" => user, "start" => start, "end" => endOfWorktime} = params) do
    Logger.warn(Timex.parse!(start, "{YYYY}-{0M}-{0D} {h24}:{m}:{s}"))

    workingtime =
      Workingtimes.getWorkingtimeByUser(
        user,
        Timex.parse!(start, "{YYYY}-{0M}-{0D} {h24}:{m}:{s}"),
        Timex.parse!(endOfWorktime, "{YYYY}-{0M}-{0D} {h24}:{m}:{s}")
      )

    render(conn, "index.json", workingtimes: workingtime)
  end

  def createWorkingtimeByUser(conn, %{"userID" => user_id, "workingtime" => workingtime_params}) do
    userTest = Guardian.Plug.current_resource(conn)
    roleTest = userTest.role_id

    cond do
      roleTest == 1 ->
        workingtime_params = Map.put(workingtime_params, "users_id", user_id)
        Logger.info(user_id)

        with {:ok, %Workingtime{} = workingtime} <-
               Workingtimes.create_workingtime(workingtime_params) do
          conn
          |> put_status(:created)
          |> put_resp_header("location", Routes.workingtime_path(conn, :showByUser, workingtime))
          |> render("show.json", workingtime: workingtime)
        end

      roleTest == 2 ->
        workingtime_params = Map.put(workingtime_params, "users_id", user_id)
        Logger.info(user_id)

        with {:ok, %Workingtime{} = workingtime} <-
               Workingtimes.create_workingtime(workingtime_params) do
          conn
          |> put_status(:created)
          |> put_resp_header("location", Routes.workingtime_path(conn, :showByUser, workingtime))
          |> render("show.json", workingtime: workingtime)
        end

      roleTest == 3 ->
        conn |> Plug.Conn.halt()

      true ->
        conn |> Plug.Conn.halt()
    end
  end
end
