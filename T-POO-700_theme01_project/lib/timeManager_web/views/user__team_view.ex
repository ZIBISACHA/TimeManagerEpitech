defmodule TimeManagerWeb.User_TeamView do
  use TimeManagerWeb, :view
  alias TimeManagerWeb.User_TeamView
  alias TimeManagerWeb.TeamView
  alias TimeManagerWeb.UserView

  def render("index.json", %{user_team: user_team}) do
    %{data: render_many(user_team, User_TeamView, "user__team.json")}
  end

  def render("show.json", %{user__team: user__team}) do
    %{data: render_one(user__team, User_TeamView, "user__team.json")}
  end

  def render("userTeam.json", %{team: team, members: members}) do
    %{users: render_many(members, UserView, "user.json"), Team: render_one(team, TeamView, "team.json")}
  end

  def render("teamMembers.json", %{teams: teams}) do
    %{teams: render_many(teams, TeamView, "team.json")}
  end

  def render("user__team.json", %{user__team: user__team}) do
    %{id: user__team.id}
  end
end
