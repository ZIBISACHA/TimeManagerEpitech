defmodule TimeManagerWeb.User_TeamControllerTest do
  use TimeManagerWeb.ConnCase

  alias TimeManager.Users_Teams
  alias TimeManager.Users_Teams.User_Team

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  def fixture(:user__team) do
    {:ok, user__team} = Users_Teams.create_user__team(@create_attrs)
    user__team
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all user_team", %{conn: conn} do
      conn = get(conn, Routes.user__team_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user__team" do
    test "renders user__team when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user__team_path(conn, :create), user__team: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user__team_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user__team_path(conn, :create), user__team: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user__team" do
    setup [:create_user__team]

    test "renders user__team when data is valid", %{conn: conn, user__team: %User_Team{id: id} = user__team} do
      conn = put(conn, Routes.user__team_path(conn, :update, user__team), user__team: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user__team_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user__team: user__team} do
      conn = put(conn, Routes.user__team_path(conn, :update, user__team), user__team: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user__team" do
    setup [:create_user__team]

    test "deletes chosen user__team", %{conn: conn, user__team: user__team} do
      conn = delete(conn, Routes.user__team_path(conn, :delete, user__team))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user__team_path(conn, :show, user__team))
      end
    end
  end

  defp create_user__team(_) do
    user__team = fixture(:user__team)
    %{user__team: user__team}
  end
end
