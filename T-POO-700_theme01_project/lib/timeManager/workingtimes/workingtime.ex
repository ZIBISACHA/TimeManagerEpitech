defmodule TimeManager.Workingtimes.Workingtime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtimes" do
    field :end, :naive_datetime,null: false
    field :start, :naive_datetime,null: false

    belongs_to :users, TimeManager.Users.User
    timestamps()
  end

  @doc false
  def changeset(workingtime, attrs) do
    workingtime
    |> cast(attrs, [:start, :end, :users_id])
    |> validate_required([:start, :end])
  end
end
