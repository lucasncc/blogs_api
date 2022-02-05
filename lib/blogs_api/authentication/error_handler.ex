defmodule BlogsApi.Guardian.AuthHandler do
  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler

  def auth_error(conn, {type, _reason}, _opts) do
    body = Jason.encode!(%{error: to_string(type)})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(400, body)
  end

end
