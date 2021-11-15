defmodule AuthPow.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  alias AuthPow.Articles.Article

  schema "users" do
    pow_user_fields()

    has_many :articles, Article
    timestamps()
  end
end
