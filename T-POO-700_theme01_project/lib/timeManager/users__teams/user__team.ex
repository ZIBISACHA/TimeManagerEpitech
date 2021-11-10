defmodule TimeManager.Users_Teams.User_Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_team" do
    belongs_to :team, TimeManager.Teams.Team, references: :id
    belongs_to :user, TimeManager.Users.User, references: :id
    timestamps()
  end

  @doc false
  def changeset(user__team, attrs) do
    user__team
    |> cast(attrs, [:user_id,:team_id])
    |> validate_required([])
  end
end
