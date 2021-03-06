defmodule BlogsApi.Blog do
  @moduledoc """
  The Blog context.
  """

  import Ecto.Query, warn: false
  alias BlogsApi.Repo

  alias BlogsApi.Blog.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    query = from u in User, select: %{id: u.id, displayName: u.displayName, email: u.email, image: u.image}
    Repo.all(query)
    # Repo.all(User)
  end

  @doc """
  Gets a single user by id.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Gets a single user by email.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user_email!(david@domain.com)
      %User{}

      iex> get_user!(amanda@domain.com)
      ** (Ecto.NoResultsError)

  """
  def get_user_by_email(email) do
    query = from u in User, where: u.email == ^email

    case Repo.one(query) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  @doc """
  Validate encrypted password.

  """
  def validate_password(password, encrypted_password) do
    Bcrypt.verify_pass(password, encrypted_password)
  end

  @doc """
  Authenticate user by entering email and email.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user_email!(david@domain.com)
      %User{}

      iex> get_user!(amanda@domain.com)
      ** (Ecto.NoResultsError)

  """
  def authenticate_user(email, password) do
    with {:ok, user} <- get_user_by_email(email) do
      case validate_password(password, user.password) do
        false -> {:error, :unauthorized}
        false when email=="" -> {:error, :no_email}
        false when password=="" -> {:error, :no_password}
        true -> {:ok, user}
      end
    end
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  alias BlogsApi.Blog.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    query = from p in Post,
      join: u in User,
      on: [id: p.user_id],
      select: %{id: p.id, inserted_at: p.inserted_at, updated_at: p.updated_at, title: p.title, content: p.content,
        user_id: p.user_id, user_displayName: u.displayName, user_email: u.email, user_image: u.image}

    Repo.all(query)

    #Repo.all(Post)
  end

  def list_posts_search(term) do
    like = "%#{term}%"

    query = from p in Post,
    where: like(p.title, ^like) or like(p.content, ^like),
    join: u in User,
    on: [id: p.user_id],
    select: %{id: p.id, inserted_at: p.inserted_at, updated_at: p.updated_at, title: p.title, content: p.content,
      user_id: p.user_id, user_displayName: u.displayName, user_email: u.email, user_image: u.image}

    Repo.all(query)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  def get_post_and_user!(id) do
    query = from p in Post,
      where: p.id == ^id,
      join: u in User,
      on: [id: p.user_id],
      select: %{id: p.id, inserted_at: p.inserted_at, updated_at: p.updated_at, title: p.title, content: p.content,
        user_id: p.user_id, user_displayName: u.displayName, user_email: u.email, user_image: u.image}

    case Repo.one(query) do
      nil -> {:error, :not_found}
      post -> {:ok, post}
    end

  end



  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}, user_id) do
    update_attrs = Map.put(attrs, "user_id", user_id)
    %Post{}
    |> Post.changeset(update_attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end
end
