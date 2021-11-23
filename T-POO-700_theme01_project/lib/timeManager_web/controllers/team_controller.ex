require Logger

defmodule TimeManagerWeb.TeamController do
  use TimeManagerWeb, :controller
  import TimeManager.Authorization
  alias TimeManager.Teams
  alias TimeManager.Teams.Team

  action_fallback(TimeManagerWeb.FallbackController)

  def index(conn, _params) do
    teams = Teams.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def create(conn, %{"team" => team_params}) do
    userTest = Guardian.Plug.current_resource(conn)
    roleTest = userTest.role_id

    if can(roleTest) |> create?(Team) do
      with {:ok, %Team{} = team} <- Teams.create_team(team_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.team_path(conn, :show, team))
        |> render("show.json", team: team)
      end
    else
      conn
      |> Plug.Conn.halt()
    end
  end

  def show(conn, %{"id" => id}) do
    userTest = Guardian.Plug.current_resource(conn)
    roleTest = userTest.role_id

    cond do
      roleTest == 1 ->
        team = Teams.get_team!(id)
        render(conn, "show.json", team: team)

      roleTest == 2 ->
        team = Teams.get_team!(id)
        render(conn, "show.json", team: team)

      roleTest == 3 ->
        conn |> Plug.Conn.halt()

      true ->
        conn |> Plug.Conn.halt()
    end
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Teams.get_team!(id)

    with {:ok, %Team{} = team} <- Teams.update_team(team, team_params) do
      render(conn, "show.json", team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Teams.get_team!(id)

    with {:ok, %Team{}} <- Teams.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end

  def getTeamMembers(conn, %{"userID" => userID}) do
    userTest = Guardian.Plug.current_resource(conn)
    roleTest = userTest.role_id

    if can(roleTest) |> getTeamMembers?(Team) do
      member = Teams.getTeamID(userID)
      team = Teams.get_team!(member.team_id)
      members = Teams.getTeamMembers(member.team_id)
      # Logger.info(members)
      render(conn, "member.json", users: members, team: team)
    else
      conn
      |> Plug.Conn.halt()
    end
  end
end
