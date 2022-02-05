defmodule BlogsApi.Guardian.AuthPipeline do
  @claims %{typ: "access"}

  use Guardian.Plug.Pipeline,
    otp_app: :blogs_api,
    module: BlogsApi.Guardian,
    error_handler: BlogsApi.Guardian.AuthErrorHandler

  # If there is an authorization header, restrict it to an access token and validate it
  plug(Guardian.Plug.VerifyHeader, claims: @claims, schema: "Bearer")
  # Checks autentication
  plug(Guardian.Plug.EnsureAuthenticated)
  # Ensure resource
  plug(Guardian.Plug.LoadResource, ensure: true)
end
