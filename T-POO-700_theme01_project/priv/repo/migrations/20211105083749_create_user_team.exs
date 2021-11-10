defmodule TimeManager.Repo.Migrations.CreateUserTeam do
  use Ecto.Migration

  def change do
    create table(:user_team) do
      add :user_id, references(:users, on_delete: :nothing)
      add :team_id, references(:teams, on_delete: :nothing)

      timestamps()
    end
  end
end
