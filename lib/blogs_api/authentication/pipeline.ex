defmodule BlogsApi.Guardian.AuthPipeline do
  @claims %{type: "access"}

  use Guardian.Plug.Pipeline,
    otp_app: :blogs_api,
    module: BlogsApi.Guardian,
    error_handler: BlogsApi.Guardian.AuthErrorHandler

  plug(Guardian.Plug.VerifyHeader, claims: @claims, schema: "Bearer")
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource, ensure: true)
end
