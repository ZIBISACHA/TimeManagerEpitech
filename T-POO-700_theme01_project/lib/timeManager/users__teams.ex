defmodule TimeManager.Users_Teams do
  @moduledoc """
  The Users_Teams context.
  """

  import Ecto.Query, warn: false
  alias TimeManager.Repo

  alias TimeManager.Users_Teams.User_Team

  @doc """
  Returns the list of user_team.

  ## Examples

      iex> list_user_team()
      [%User_Team{}, ...]

  """
  def list_user_team do
    Repo.all(User_Team)
  end

  @doc """
  Gets a single user__team.

  Raises `Ecto.NoResultsError` if the User  team does not exist.

  ## Examples

      iex> get_user__team!(123)
      %User_Team{}

      iex> get_user__team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user__team!(id), do: Repo.get!(User_Team, id)


  def get_user__team_ByUser(userID,teamID) do
    Repo.one(from uT in User_Team, where: uT.user_id == ^userID and uT.team_id == ^teamID)
  end

  @doc """
  Creates a user__team.

  ## Examples

      iex> create_user__team(%{field: value})
      {:ok, %User_Team{}}

      iex> create_user__team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user__team(attrs \\ %{}) do
    %User_Team{}
    |> User_Team.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user__team.

  ## Examples

      iex> update_user__team(user__team, %{field: new_value})
      {:ok, %User_Team{}}

      iex> update_user__team(user__team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user__team(%User_Team{} = user__team, attrs) do
    user__team
    |> User_Team.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user__team.

  ## Examples

      iex> delete_user__team(user__team)
      {:ok, %User_Team{}}

      iex> delete_user__team(user__team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user__team(%User_Team{} = user__team) do
    Repo.delete(user__team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user__team changes.

  ## Examples

      iex> change_user__team(user__team)
      %Ecto.Changeset{data: %User_Team{}}

  """
  def change_user__team(%User_Team{} = user__team, attrs \\ %{}) do
    User_Team.changeset(user__team, attrs)
  end

  def get_membersDetails(team) do
    Repo.preload(team,:users)
  end

  def getTeams(user) do
    Repo.preload(user,:teams)
  end
end
