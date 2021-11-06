defmodule TimeManager.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt

  schema "users" do
    field(:email, :string, null: false)
    field(:username, :string, null: false)
    field(:password_hash, :string)
    # Virtual fields:
    field(:password, :string, virtual: true)
    field(:password_confirmation, :string, virtual: true)

    belongs_to :role, TimeManager.Roles.Role
    many_to_many :teams, TimeManager.Teams.Team, join_through: "user_team"
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :teams_id, :password, :password_confirmation, :role_id])
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> validate_required([:username, :email, :password, :password_confirmation])
    |> unique_constraint(:email)
    |> validate_length(:password, min: 6)
    # Check that password === password_confirmation
    |> validate_confirmation(:password)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(
          changeset,
          :password_hash,
          Bcrypt.hash_pwd_salt(pass)
        )

      _ ->
        changeset
    end
  end
end
