defmodule BlogsApiWeb.PostView do
  use BlogsApiWeb, :view
  alias BlogsApiWeb.PostView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{
      id: post.id,
      published: post.inserted_at,
      updated: post.updated_at,
      title: post.title,
      content: post.content,
      user: %{
        id: post.user_id,
        displayName: post.user_displayName,
        email: post.user_email,
        image: post.user_image
      }
    }
  end
end
