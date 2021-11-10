defmodule TimeManager.Repo.Migrations.CreateRoles do
  use Ecto.Migration
  import Ecto.Query
  alias TimeManager.Repo

  def change do
    create table(:roles) do
      add :name, :string
    end
     execute(&execute_up/0)
  end
  defp execute_up, do: repo().query!("INSERT INTO roles(name) Values ('Manager'),('Admin'),('Employees');", [], [log: :info])
end
