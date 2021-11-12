require Logger
defmodule TimeManagerWeb.User_TeamController do
  use TimeManagerWeb, :controller

  alias TimeManager.Users_Teams
  alias TimeManager.Users_Teams.User_Team
  alias TimeManager.Teams
  alias TimeManager.Users

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    user_team = Users_Teams.list_user_team()
    render(conn, "index.json", user_team: user_team)
  end

  def create(conn, %{"user__team" => user__team_params}) do
    with {:ok, %User_Team{} = user__team} <- Users_Teams.create_user__team(user__team_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user__team_path(conn, :show, user__team))
      |> render("show.json", user__team: user__team)
    end
  end

  def show(conn, %{"id" => id}) do
    user__team = Users_Teams.get_user__team!(id)
    render(conn, "show.json", user__team: user__team)
  end

  def update(conn, %{"id" => id, "user__team" => user__team_params}) do
    user__team = Users_Teams.get_user__team!(id)

    with {:ok, %User_Team{} = user__team} <- Users_Teams.update_user__team(user__team, user__team_params) do
      render(conn, "show.json", user__team: user__team)
    end
  end

  def delete(conn, %{"id" => id}) do
    user__team = Users_Teams.get_user__team!(id)

    with {:ok, %User_Team{}} <- Users_Teams.delete_user__team(user__team) do
      send_resp(conn, :no_content, "")
    end
  end

  def deleteByUser(conn, %{"userID" => userID}) do 
    user__team = Users_Teams.get_user__team_ByUser(userID)

    with {:ok, %User_Team{}} <- Users_Teams.delete_user__team(user__team) do
      send_resp(conn, :no_content, "")
    end
  end

  def getUserTeam(conn, %{"teamID" => teamID}) do
    team = Teams.get_team!(teamID)
    members = Users_Teams.get_membersDetails(team)
    Logger.info members.users
    render(conn, "userTeam.json", team: team,members: members.users)
  end

  def getTeams(conn, %{"userID" => userID}) do
    user = Users.get_user!(userID)
    teams = Users_Teams.getTeams(user)
    teams = teams.teams
    render(conn, "teamMembers.json", teams: teams)
  end
end
