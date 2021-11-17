defmodule AuthPow.Repo.Migrations.AddArticleIdToComment do
  use Ecto.Migration

  def change do
    alter table("comments") do
      add :user_id, references(:users), null: false
      add :article_id, references(:articles), null: false
    end
  end
end
