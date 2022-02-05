defmodule BlogsApiWeb.SessionView do
  use BlogsApiWeb, :view

  def render("token.json", %{access_token: access_token}) do
    %{access_token: access_token}
  end

end
