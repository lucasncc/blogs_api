defmodule BlogsApi.Blog.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :displayName, :string
    field :email, :string
    field :image, :string
    field :password, :string

    has_many :posts, Blog.Post

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:displayName, :email, :password, :image])
    |> validate_required([:email, :password])
    |> unique_constraint(:email, message: "Usuário já existe")
    |> validate_length(:displayName, min: 8, message: "\"displayName\" length must be at least 8 characters long")
    |> validate_length(:password, min: 6, message: "\"password\" length must be 6 characters long")
    |> validate_format(:email,~r/@/, message: "\"email\" must be a valid email")
    |> update_change(:email, &String.downcase(&1))
    |> encrypt_password()
  end

  defp encrypt_password(user) do
    with password <- fetch_field!(user, :password) do
      # encrypted_password = Bcrypt.Base.hash_password(password, Bcrypt.Base.gen_salt(12, true))
      %{password_hash: encrypted_password} = Bcrypt.add_hash(password)
      put_change(user, :password, encrypted_password)
    end
  end

end
