defmodule TimeManager.Users_TeamsTest do
  use TimeManager.DataCase

  alias TimeManager.Users_Teams

  describe "user_team" do
    alias TimeManager.Users_Teams.User_Team

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def user__team_fixture(attrs \\ %{}) do
      {:ok, user__team} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users_Teams.create_user__team()

      user__team
    end

    test "list_user_team/0 returns all user_team" do
      user__team = user__team_fixture()
      assert Users_Teams.list_user_team() == [user__team]
    end

    test "get_user__team!/1 returns the user__team with given id" do
      user__team = user__team_fixture()
      assert Users_Teams.get_user__team!(user__team.id) == user__team
    end

    test "create_user__team/1 with valid data creates a user__team" do
      assert {:ok, %User_Team{} = user__team} = Users_Teams.create_user__team(@valid_attrs)
    end

    test "create_user__team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users_Teams.create_user__team(@invalid_attrs)
    end

    test "update_user__team/2 with valid data updates the user__team" do
      user__team = user__team_fixture()
      assert {:ok, %User_Team{} = user__team} = Users_Teams.update_user__team(user__team, @update_attrs)
    end

    test "update_user__team/2 with invalid data returns error changeset" do
      user__team = user__team_fixture()
      assert {:error, %Ecto.Changeset{}} = Users_Teams.update_user__team(user__team, @invalid_attrs)
      assert user__team == Users_Teams.get_user__team!(user__team.id)
    end

    test "delete_user__team/1 deletes the user__team" do
      user__team = user__team_fixture()
      assert {:ok, %User_Team{}} = Users_Teams.delete_user__team(user__team)
      assert_raise Ecto.NoResultsError, fn -> Users_Teams.get_user__team!(user__team.id) end
    end

    test "change_user__team/1 returns a user__team changeset" do
      user__team = user__team_fixture()
      assert %Ecto.Changeset{} = Users_Teams.change_user__team(user__team)
    end
  end
end
