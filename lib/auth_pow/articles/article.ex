defmodule AuthPow.Articles.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :content, :string
    field :title, :string
    belongs_to :user, AuthPow.Users.User

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :content, :user_id])
    |> validate_required([:title, :content, :user_id])
  end
end
