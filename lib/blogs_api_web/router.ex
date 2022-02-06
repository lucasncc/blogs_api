defmodule BlogsApiWeb.Router do
  use BlogsApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug BlogsApi.Guardian.AuthPipeline
  end

  scope "/api", BlogsApiWeb do
    pipe_through :api

    # resources "/user", UserController, except: [:new, :edit]
    resources "/user", UserController, only: [:create]

    resources "/post", PostController, only: [:show, :index]
    #get "/post/search?q=:searchTerm", PostController, :show_post_term

    post "/login", SessionController, :new

  end

  scope "/api", BlogsApiWeb do
    pipe_through [:api, :auth]

    post "/login/refresh", SessionController, :refresh
    post "/login/delete", SessionController, :delete

    resources "/user", UserController, except: [:new, :edit, :create, :delete, :update]

    resources "/post", PostController, except: [:new, :edit, :show, :index]

    delete "/user/me", UserController, :delete_me

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
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: BlogsApiWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
