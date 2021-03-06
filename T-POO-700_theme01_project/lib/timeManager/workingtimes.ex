defmodule TimeManager.Workingtimes do
  @moduledoc """
  The Workingtimes context.
  """

  import Ecto.Query, warn: false
  alias TimeManager.Repo

  alias TimeManager.Workingtimes.Workingtime
  alias TimeManager.Users.User
  alias TimeManager.Users_Teams.User_Team

  @doc """
  Returns the list of workingtimes.

  ## Examples

      iex> list_workingtimes()
      [%Workingtime{}, ...]

  """
  def list_workingtimes do
    Repo.all(Workingtime)
  end

  @doc """
  Gets a single workingtime.

  Raises `Ecto.NoResultsError` if the Workingtime does not exist.

  ## Examples

      iex> get_workingtime!(123)
      %Workingtime{}

      iex> get_workingtime!(456)
      ** (Ecto.NoResultsError)

  """
  def get_workingtime_by_user!(id, userID) do
    Repo.get_by!(Workingtime, [users_id: userID, id: id], preload: [:users])
  end

  def get_workingtime!(id) do
    Repo.get!(Workingtime, id)
  end

  # do: Repo.get!(Workingtime, id)
  @doc """
  Creates a workingtime.

  ## Examples

      iex> create_workingtime(%{field: value})
      {:ok, %Workingtime{}}

      iex> create_workingtime(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_workingtime(attrs \\ %{}) do
    %Workingtime{}
    |> Workingtime.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a workingtime.

  ## Examples

      iex> update_workingtime(workingtime, %{field: new_value})
      {:ok, %Workingtime{}}

      iex> update_workingtime(workingtime, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_workingtime(%Workingtime{} = workingtime, attrs) do
    workingtime
    |> Workingtime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a workingtime.

  ## Examples

      iex> delete_workingtime(workingtime)
      {:ok, %Workingtime{}}

      iex> delete_workingtime(workingtime)
      {:error, %Ecto.Changeset{}}

  """
  def delete_workingtime(%Workingtime{} = workingtime) do
    Repo.delete(workingtime)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking workingtime changes.

  ## Examples

      iex> change_workingtime(workingtime)
      %Ecto.Changeset{data: %Workingtime{}}

  """
  def change_workingtime(%Workingtime{} = workingtime, attrs \\ %{}) do
    Workingtime.changeset(workingtime, attrs)
  end

  def getByUser!(user_id) do
    # Repo.get_by(Workingtime, users_id: user_id, start: <> :end)
    from(w in Workingtime, where: w.users_id == ^user_id and w.start == w.end)
    |> Repo.one()
  end

  def getWorkingtimeByUser(user, start, endOfWorktime) do
    Repo.all(
      from(w in Workingtime,
        where: w.users_id == ^user,
        where: w.start > ^start,
        where: w.end < ^endOfWorktime,
        preload: [:users]
      )
    )
  end

  def getWorkingtimeByTeam(team, start, endOfWorktime) do
    Repo.all(
      from w in Workingtime,
        left_join: u in User, on: u.id == w.users_id,
        left_join: t in User_Team, on: u.id == t.user_id,
        where: t.team_id == ^team,
        where: w.start > ^start,
        where: w.end < ^endOfWorktime,
        preload: [:users]
    )
  end
end
