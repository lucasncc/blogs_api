defmodule BlogsApi.Guardian do
  use Guardian, otp_app: :blogs_api
  alias BlogsApi.Blog

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = Blog.get_user!(id)
    {:ok, resource}
  end
end
