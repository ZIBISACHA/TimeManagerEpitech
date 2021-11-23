require Logger

defmodule TimeManagerWeb.ClockController do
  use TimeManagerWeb, :controller

  alias TimeManager.Clocks
  alias TimeManager.Clocks.Clock

  alias TimeManager.Workingtimes
  alias TimeManager.Workingtimes.Workingtime

  action_fallback(TimeManagerWeb.FallbackController)

  def index(conn, _params) do
    clock = Clocks.list_clock()
    render(conn, "index.json", clock: clock)
  end

  def show(conn, %{"id" => id}) do
    clock = Clocks.get_clock!(id)
    render(conn, "show.json", clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Clocks.get_clock!(id)
    Logger.info(clock)

    with {:ok, %Clock{} = clock} <- Clocks.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Clocks.get_clock!(id)

    with {:ok, %Clock{}} <- Clocks.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end

  def showByUser(conn, %{"userID" => user_id}) do
    clock = Clocks.getClockByUser!(user_id)
    render(conn, "index.json", clock: clock)
  end

  def createByUser(conn, %{
        "userID" => user_id,
        "clock" => clock_params,
        "workingtimes" => workingtime_params
      }) do
    clock = Clocks.getClockTrueByUser!(user_id)

    if clock do
      with {:ok, %Clock{} = clock} <- Clocks.update_clock(clock, clock_params) do
        # render(conn, "show.json", clock: clock)
        if clock.status do
          workingtime_params = Map.put(workingtime_params, "users_id", user_id)

          with {:ok, %Workingtime{} = workingtime} <-
                 Workingtimes.create_workingtime(workingtime_params) do
            conn
            |> put_status(:created)
            |> put_resp_header(
              "location",
              Routes.workingtime_path(conn, :showByUser, workingtime)
            )
            |> render("clockWork.json", clock: clock, workingtime: workingtime)
          end
        else
          workingtime = Workingtimes.getByUser!(user_id)

          with {:ok, %Workingtime{} = workingtime} <-
                 Workingtimes.update_workingtime(workingtime, workingtime_params) do
            render(conn, "clockWork.json", clock: clock, workingtime: workingtime)
          end
        end
      end
    else
      clock_params = Map.put(clock_params, "users_id", user_id)

      with {:ok, %Clock{} = clockUser} <- Clocks.create_clock(clock_params) do
        workingtime_params = Map.put(workingtime_params, "users_id", user_id)

        with {:ok, %Workingtime{} = workingtime} <-
               Workingtimes.create_workingtime(workingtime_params) do
          conn
          |> put_status(:created)
          |> put_resp_header("location", Routes.workingtime_path(conn, :showByUser, workingtime))
          |> render("clockWork.json", clock: clockUser, workingtime: workingtime)
        end
      end
    end
  end
end
