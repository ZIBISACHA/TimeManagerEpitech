defmodule TimeManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string, null: false
      add :teams_id, references(:teams, on_delete: :nothing)
      timestamps()
    end

  end
end
