defmodule TimeManager.Authorization do
  alias __MODULE__
  alias TimeManager.Users.User
  alias TimeManager.Workingtimes.Workingtime
  alias TimeManager.Teams.Team
  alias TimeManager.Users_Teams.User_Team

  defstruct role: nil,
            create: %{},
            read: %{},
            update: %{},
            delete: %{},
            show: %{},
            getUserTeam: %{},
            getTeams: %{},
            getTeamMembers: %{}

  def can(3 = role) do
    grant(role)
    |> read(User)
    |> read(Workingtime)
    |> show(Workingtime)
  end

  def can(1 = role) do
    grant(role)
    |> update(User)
    |> create(Workingtime)
    |> all(Team)
    |> all(User_Team)

    # |> create(Team)
    # |> create(User_Team)
    # |> getUserTeam(User_Team)
    # |> getTeams(User_Team)
    # |> getTeamMembers(Team)
    # |> show(Team)
  end

  def can(2 = role) do
    grant(role)
    |> all(User)
    |> all(Workingtime)
    |> all(Team)
    |> all(User_Team)
    |> all(Team)
    |> all(User_Team)
  end

  def grant(role), do: %Authorization{role: role}

  def read(authorization, resource), do: put_action(authorization, :read, resource)

  def create(authorization, resource), do: put_action(authorization, :create, resource)

  def update(authorization, resource), do: put_action(authorization, :update, resource)

  def delete(authorization, resource), do: put_action(authorization, :delete, resource)

  def show(authorization, resource), do: put_action(authorization, :delete, resource)

  # Routes related to User_TeamController
  def getUserTeam(authorization, resource), do: put_action(authorization, :getUserTeam, resource)

  def getTeams(authorization, resource), do: put_action(authorization, :getTeams, resource)

  # Routes related to TeamController
  def getTeamMembers(authorization, resource),
    do: put_action(authorization, :getTeamMembers, resource)

  def all(authorization, resource) do
    authorization
    |> create(resource)
    |> read(resource)
    |> update(resource)
    |> delete(resource)
    |> show(resource)
    |> getUserTeam(resource)
    |> getTeams(resource)
    |> getTeamMembers(resource)
  end

  def read?(authorization, resource) do
    Map.get(authorization.read, resource, false)
  end

  def show?(authorization, resource) do
    Map.get(authorization.show, resource, false)
  end

  def create?(authorization, resource) do
    Map.get(authorization.create, resource, false)
  end

  def update?(authorization, resource) do
    Map.get(authorization.update, resource, false)
  end

  def delete?(authorization, resource) do
    Map.get(authorization.delete, resource, false)
  end

  def getUserTeam?(authorization, resource) do
    Map.get(authorization.getUserTeam, resource, false)
  end

  def getTeams?(authorization, resource) do
    Map.get(authorization.getTeams, resource, false)
  end

  def getTeamMembers?(authorization, resource) do
    Map.get(authorization.getTeamMembers, resource, false)
  end

  defp put_action(authorization, action, resource) do
    updated_action =
      authorization
      |> Map.get(action)
      |> Map.put(resource, true)

    Map.put(authorization, action, updated_action)
  end
end
