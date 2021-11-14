# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TimeManager.Repo.insert!(%TimeManager.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias TimeManager.Repo
alias TimeManager.Users.User
alias TimeManager.Users_Teams.User_Team
alias TimeManager.Teams.Team
alias TimeManager.Workingtimes.Workingtime

# ------------------------------------------------
#               USERS
# ------------------------------------------------

Repo.insert!(%User{
  username: "John Doe 1",
  email: "john.doe1@gotham.com",
  # Employee
  roles_id: 3
  # password_hash: "gotham123",
  # password_confirmation: "gotham123"
})

Repo.insert!(%User{
  username: "John Doe 2",
  email: "john.doe2@gotham.com",
  # Employee
  roles_id: 3
  # password_hash: "gotham123",
  # password_confirmation: "gotham123"
})

Repo.insert!(%User{
  username: "John Doe 3",
  email: "john.doe3@gotham.com",
  # Employee
  roles_id: 3
  # password_hash: "gotham123",
  # password_confirmation: "gotham123"
})

Repo.insert!(%User{
  username: "Paul Dupont",
  email: "paul.dupont@gotham.com",
  # Manager
  roles_id: 2
  # password_hash: "gotham123",
  # password_confirmation: "gotham123"
})

Repo.insert!(%User{
  username: "Admin",
  email: "admin@gotham.com",
  # Admin
  roles_id: 1
  # password_hash: "gotham123",
  # password_confirmation: "gotham123"
})

# ------------------------------------------------
#               TEAMS
# ------------------------------------------------

Repo.insert!(%Team{
  name: "Tech"
})

Repo.insert!(%User_Team{
  user_id: 1,
  team_id: 1
})

Repo.insert!(%User_Team{
  user_id: 2,
  team_id: 1
})

Repo.insert!(%User_Team{
  user_id: 3,
  team_id: 1
})

Repo.insert!(%User_Team{
  user_id: 4,
  team_id: 1
})

# ------------------------------------------------
#               WORKINGTIMES
# ------------------------------------------------

Enum.each(["04", "05", "06", "07", "08", "11", "12", "13", "14", "15"], fn x ->
  Repo.insert!(%Workingtime{
  start: Timex.parse!("2021-10-#{x} 08:00:00", "{YYYY}-{0M}-{0D} {h24}:{m}:{s}"),
  end: Timex.parse!("2021-10-#{x} 12:00:00", "{YYYY}-{0M}-{0D} {h24}:{m}:{s}"),
    users_id: 1
  })
  Repo.insert!(%Workingtime{
    start: Timex.parse!("2021-10-#{x} 13:00:00", "{YYYY}-{0M}-{0D} {h24}:{m}:{s}"),
    end: Timex.parse!("2021-10-#{x} 16:00:00", "{YYYY}-{0M}-{0D} {h24}:{m}:{s}"),
      users_id: 1
    })
  Repo.insert!(%Workingtime{
    start: Timex.parse!("2021-10-#{x} 09:00:00", "{YYYY}-{0M}-{0D} {h24}:{m}:{s}"),
    end: Timex.parse!("2021-10-#{x} 12:00:00", "{YYYY}-{0M}-{0D} {h24}:{m}:{s}"),
      users_id: 2
    })
  Repo.insert!(%Workingtime{
    start: Timex.parse!("2021-10-#{x} 13:00:00", "{YYYY}-{0M}-{0D} {h24}:{m}:{s}"),
    end: Timex.parse!("2021-10-#{x} 17:00:00", "{YYYY}-{0M}-{0D} {h24}:{m}:{s}"),
      users_id: 2
    })
  Repo.insert!(%Workingtime{
    start: Timex.parse!("2021-10-#{x} 08:00:00", "{YYYY}-{0M}-{0D} {h24}:{m}:{s}"),
    end: Timex.parse!("2021-10-#{x} 12:00:00", "{YYYY}-{0M}-{0D} {h24}:{m}:{s}"),
      users_id: 3
    })
  Repo.insert!(%Workingtime{
    start: Timex.parse!("2021-10-#{x} 14:00:00", "{YYYY}-{0M}-{0D} {h24}:{m}:{s}"),
    end: Timex.parse!("2021-10-#{x} 17:00:00", "{YYYY}-{0M}-{0D} {h24}:{m}:{s}"),
      users_id: 3
    })
end)
