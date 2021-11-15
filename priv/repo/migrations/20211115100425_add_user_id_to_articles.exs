defmodule AuthPow.Repo.Migrations.AddUserIdToArticles do
  use Ecto.Migration

  def change do
    alter table("articles") do
      add :user_id, references(:users), null: false
    end
  end
end
