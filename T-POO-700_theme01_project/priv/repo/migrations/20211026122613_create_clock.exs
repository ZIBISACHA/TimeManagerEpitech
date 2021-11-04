defmodule TimeManager.Repo.Migrations.CreateClock do
  use Ecto.Migration

  def change do
    create table(:clock) do
      add :time, :naive_datetime
      add :status, :boolean, default: false, null: false
      add :users_id, references(:users, on_delete: :nothing)

      timestamps()
    end
  end
end
