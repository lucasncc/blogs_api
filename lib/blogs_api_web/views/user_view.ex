defmodule BlogsApiWeb.UserView do
  use BlogsApiWeb, :view
  alias BlogsApiWeb.UserView

  def render("index.json", %{users: users}) do
    # %{data: render_many(users, UserView, "user.json")}
    render_many(users, UserView, "user.json")
  end

  def render("show.json", %{user: user}) do
    # %{data: render_one(user, UserView, "user.json")}
    render_one(user, UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      displayName: user.displayName,
      email: user.email,
      # password: user.password,
      image: user.image
    }
  end

  def render("token.json", %{access_token: access_token}) do
    %{access_token: access_token}
  end
end
