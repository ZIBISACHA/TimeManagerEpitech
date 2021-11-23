defmodule TimeManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:username, :string, null: false)
      add(:email, :string, null: false)
      add(:password_hash, :string)
      add(:role_id, references(:roles, on_delete: :nothing))
      timestamps()
    end

    execute(&execute_up/0)
  end

  defp execute_up,
    do:
      repo().query!(
        "
  INSERT INTO users(username, email, password_hash, role_id, inserted_at, updated_at)
  Values ('admin', 'admin@gmail.com', '$2b$12$8NbOuf9vs5ooPra1Jk7TNuQc/7uxp.RTJ2KjOA/fKXlB2t6S9diyy', '2', '2021-11-15 20:00:00', '2021-11-16 20:00:00');",
        [],
        log: :info
      )
end
