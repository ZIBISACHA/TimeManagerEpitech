defmodule TimeManager.Clocks.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clock" do
    field :status, :boolean, default: true
    field :time, :naive_datetime, null: false
    
    belongs_to :users, TimeManager.Users.User
    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status, :users_id])
    |> validate_required([:time, :status])
  end
end
