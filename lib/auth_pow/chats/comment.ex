defmodule AuthPow.Chats.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :message, :string

    belongs_to :article, AuthPow.Articles.Article
    belongs_to :user, AuthPow.Users.User

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:message, :user_id, :article_id])
    |> validate_required([:message,:user_id, :article_id ])
  end
end
