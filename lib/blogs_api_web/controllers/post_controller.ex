defmodule BlogsApiWeb.PostController do
  use BlogsApiWeb, :controller

  alias BlogsApi.Blog
  alias BlogsApi.Blog.Post

  action_fallback BlogsApiWeb.FallbackController

  def index(conn, _params) do
    posts = Blog.list_posts()
    render(conn, "index.json", posts: posts)
  end

  #def create(conn, %{"post" => post_params}) do
  def create(conn, post_params) do
    user = Guardian.Plug.current_resource(conn)
    #post_params
    #|> update_change(:user_id, user.id)

    #changeset = Ecto.build_assoc(user, :post)

    #post_params_updated = Post.changeset(changeset, post_params)

    #case Post.insert_item(changeset, item_params) do

      with {:ok, %Post{} = post} <- Blog.create_post(post_params, user.id) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, post} <- Blog.get_post_and_user!(id) do
      render(conn, "show.json", post: post)
    end
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    #user = Guardian.Plug.current_resource(conn)
    post = Blog.get_post!(id)

    #with {:ok, %Post{} = post} <- Blog.update_post(post, post_params) do
    #  new_post = Blog.get_post_and_user!(id)
    #  render(conn, "show.json", post: new_post)
    #end

    with {:ok, %Post{} = post} <- Blog.update_post(post, post_params) do
      with {:ok, new_post} <- Blog.get_post_and_user!(id) do
        render(conn, "show.json", post: new_post)
      end
    end

    #case user.id == post.user_id do
    #  false -> {:error, :unauthorized}
    #  true ->
    #    with {:ok, %Post{} = post} <- Blog.update_post(post, post_params) do
    #      new_post = Blog.get_post_and_user!(id)
    #      render(conn, "show.json", post: new_post)
    #    end
    #end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)

    with {:ok, %Post{}} <- Blog.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end

  #def show_post_term() do
#
 # end
end
