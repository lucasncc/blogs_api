defmodule BlogsApi.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :content, :string
    field :title, :string
    field :user_id, :id

    #belongs_to :user, Blog.User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :user_id])
    |> validate_required([:title, :content, :user_id])
    #|> foreign_key_constraint(:user_id)
  end
end
