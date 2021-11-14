require Logger

defmodule TimeManager.Guardian do
  use Guardian, otp_app: :timeManager

  import Ecto.Query
  alias TimeManager.Repo
  alias TimeManager.Users
  alias TimeManager.Users.User

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = TimeManager.Users.get_user!(id)
    {:ok, resource}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end

  def build_claims(claims, resource, _opts) do
    claims = Map.put(claims, :role, resource.role_id)
    roleTest = Users.getRole(resource.role_id)
    Logger.info(roleTest)
    {:ok, claims}
  end
end
