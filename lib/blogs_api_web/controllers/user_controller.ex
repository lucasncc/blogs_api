defmodule BlogsApiWeb.UserController do
  use BlogsApiWeb, :controller

  alias BlogsApi.Blog
  alias BlogsApi.Blog.User
  alias BlogsApi.Guardian

  action_fallback BlogsApiWeb.FallbackController

  def index(conn, _params) do
    users = Blog.list_users()
    render(conn, "index.json", users: users)
  end

  #def create(conn, %{"user" => user_params}) do
  def create(conn, user_params) do
      with {:ok, %User{} = user} <- Blog.create_user(user_params) do

      {:ok, access_token, _claims} =
        Guardian.encode_and_sign(user, %{}, token_type: "access", ttl: {15, :minute})

      conn
      |> put_status(:created)
      |> render("token.json", access_token: access_token)

      #conn
      #|> put_status(:created)
      #|> put_resp_header("location", Routes.user_path(conn, :show, user))
      #|> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Blog.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Blog.get_user!(id)

    with {:ok, %User{} = user} <- Blog.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Blog.get_user!(id)

    with {:ok, %User{}} <- Blog.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def delete_me(conn, _params) do
    user = Guardian.Plug.current_resource(conn)

    with {:ok, %User{}} <- Blog.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
