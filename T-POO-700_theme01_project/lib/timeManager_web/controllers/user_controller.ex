require Logger

defmodule TimeManagerWeb.UserController do
  use TimeManagerWeb, :controller

  import TimeManager.Authorization
  alias TimeManager.Users
  alias TimeManager.Users.User
  alias TimeManager.Guardian

  action_fallback(TimeManagerWeb.FallbackController)

  def index(conn, %{"email" => email, "username" => username}) do
    user = Guardian.Plug.current_resource(conn)
    role = user.role_id

    if can(role) |> read?(User) do
      user = Users.get_user_by_parameters!(email, username)
      render(conn, "show.json", user: user)
    else
      # conn |> Plug.Conn.halt()
      conn |> forbidden
    end
  end

  def create(conn, %{"user" => user_params}) do
    user = Guardian.Plug.current_resource(conn)
    role = user.role_id

    if can(role) |> create?(User) do
      with {:ok, %User{} = user} <- Users.create_user(user_params),
           {:ok, token, _claims} <- Guardian.encode_and_sign(user, %{role: user.role_id}) do
        conn
        |> render("jwt.json", jwt: token)
      end
    else
      conn |> forbidden
    end
  end

  def show(conn, %{"id" => id}) do
    # user = Guardian.Plug.current_resource(conn)
    # render(conn, "user.json", user: user)
    userTest = Guardian.Plug.current_resource(conn)
    roleTest = userTest.role_id

    Logger.info("ARCANE SHOW USER")
    Logger.info(userTest)

    cond do
      roleTest == 1 ->
        user = Users.get_user!(id)
        role = Users.getRole(user.role_id)
        render(conn, "user.json", user: user, role: role)

      roleTest == 2 ->
        user = Users.get_user!(id)
        role = Users.getRole(user.role_id)
        render(conn, "user.json", user: user, role: role)

      roleTest == 3 ->
        user = Guardian.Plug.current_resource(conn)
        render(conn, "user.json", user: user)

      true ->
        conn |> forbidden
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    userTest = Guardian.Plug.current_resource(conn)
    roleTest = userTest.role_id

    cond do
      roleTest == 1 ->
        conn |> forbidden

      roleTest == 2 ->
        user = Users.get_user!(id)

        with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
          render(conn, "show.json", user: user)
        end

      roleTest == 3 ->
        conn |> forbidden

      true ->
        conn |> forbidden
    end
  end

  def delete(conn, %{"id" => id}) do
    userTest = Guardian.Plug.current_resource(conn)
    roleTest = userTest.role_id

    cond do
      roleTest == 1 ->
        conn |> forbidden

      roleTest == 2 ->
        user = Users.get_user!(id)

        with {:ok, %User{}} <- Users.delete_user(user) do
          send_resp(conn, :no_content, "")
        end

      roleTest == 3 ->
        conn |> forbidden

      true ->
        conn |> forbidden
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

  defp forbidden(conn) do
    conn
    |> put_resp_header("Content-Type", "application/json")
    |> send_resp(403, "{ \"error\": \"Not Authorized 😠\"}")
    |> halt
  end
end
