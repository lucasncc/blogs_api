defmodule BlogsApi.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :content, :text
      add :userId, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:posts, [:userId])
  end
end
