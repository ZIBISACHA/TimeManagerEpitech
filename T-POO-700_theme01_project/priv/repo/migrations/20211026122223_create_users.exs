defmodule TimeManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string, null: false
      add :role_id, references(:roles, on_delete: :nothing)
      timestamps()
    end

  end
end
