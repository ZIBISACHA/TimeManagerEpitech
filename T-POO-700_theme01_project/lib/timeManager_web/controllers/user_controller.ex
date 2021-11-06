require Logger
defmodule TimeManagerWeb.UserController do
  use TimeManagerWeb, :controller

  alias TimeManager.Users
  alias TimeManager.Users.User
  alias TimeManager.Guardian

  action_fallback(TimeManagerWeb.FallbackController)

  def index(conn, %{"email" => email, "username" => username}) do
    user = Users.get_user_by_parameters!(email, username)
    render(conn, "show.json", user: user)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    role = Users.getRole(user.role_id)
    render(conn, "userRole.json", user: user, role: role)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  # ----- REGISTRATION-------
  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Users.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", jwt: token)

      _ ->
        {:error, :unauthorized}
    end
  end

  def sign_up(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn |> render("show.json", user: user)
    end
  end

  @spec sign_out(any, any) :: :ok
  def sign_out(conn, _params) do
    conn
    |> Guardian.Plug.sign_out()
    |> resp(:ok, "logged out successfully")
  end
end
