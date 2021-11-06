defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router
  alias TimeManager.Guardian

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :jwt_authenticated do
    plug(Guardian.AuthPipeline)
  end

  scope "/api", TimeManagerWeb do
    pipe_through(:api)

    resources("/users", UserController, only: [:index, :show, :create, :update, :delete])

    scope "/users/sign_up" do
      post("/", UserController, :sign_up)
    end

    scope "/users/sign_in" do
      post("/", UserController, :sign_in)
    end

    scope "/users/sign_out" do
      post("/", UserController, :sign_out)
    end

    scope "/clocks/:userID" do
      post("/", ClockController, :createByUser)
    end

    get("/clocks/:userID", ClockController, :showByUser)

    resources("/workingtimes", WorkingtimeController, only: [:update, :delete])
    get("/workingtimes/:userID", WorkingtimeController, :showByUser)
    get("/workingtimes/:userID/:id", WorkingtimeController, :show)

    scope "/workingtimes/:userID" do
      post("/", WorkingtimeController, :createWorkingtimeByUser)
    end

    resources("/teams", TeamController, except: [:new, :edit, :show])
    resources "/userTeams", User_TeamController, except: [:new, :edit]

    get "/userTeams/team/:teamID", User_TeamController, :getUserTeam
    get "/userTeams/user/:userID", User_TeamController, :getTeams
    scope "/userTeams/user/:userID/:teamID" do
      delete "/", User_TeamController, :deleteByUser
    end

    get("/teams/:userID", TeamController, :getTeamMembers)
    get("/team/:id", TeamController, :show)
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through([:fetch_session, :protect_from_forgery])
      live_dashboard("/dashboard", metrics: TimeManagerWeb.Telemetry)
    end
  end
end
