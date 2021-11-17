defmodule AuthPowWeb.CommentController do
  use AuthPowWeb, :controller

  alias AuthPow.Articles.Article
  alias AuthPow.Chats
  alias AuthPow.Chats.Comment
  alias AuthPow.Repo

  def index(conn, params) do
    %{"article_id" => id} = params
    comments = Chats.list_comments
    render(conn, "index.html", comments: comments, article_id: String.to_integer(id))
  end

  def new(conn, params) do
    IO.inspect("New+++++++++++++++++")
    # IO.inspect Pow.Plug.current_user(conn).id
     %{"article_id" => id} = params
      article_id = String.to_integer(id)
     changeset = Chats.change_comment(%Comment{})
     comment = article_id
    # IO.inspect(changeset)
    render(conn, "new.html", comment: comment, changeset: changeset,article_id: comment)
  end

  def create(conn, %{"comment" => comment_params,"article_id" => id }) do
    IO.inspect("++++++++++COmment Create+++++++++++")
    #
    article_id = String.to_integer(id)
    article = Repo.get(Article,article_id)
    # userid = Pow.Plug.current_user(conn)
    # IO.inspect()
    comment = struct(Comment)
    IO.inspect(comment)
    IO.inspect(article_id)
    IO.inspect article.user_id
    IO.inspect(comment_params)
    comment_params = Map.put(comment_params,"user_id",article.user_id)
    comment_params = Map.put(comment_params,"article_id",article.id)

    # comment_changeset = Ecto.build_assoc(article, :comment, %{message: comment["message"], user_id: article.user_id["user_id"], article_id: id["article_id"]})
    IO.inspect(comment_params)
    # IO.inspect(conn)

    IO.inspect(%Comment{})
    # repo_comment = Repo.get(Article, article_id)
    IO.inspect("repo_comment")
    # IO.inspect(repo_comment)
    # comment = Map.put(comment,"article_id",article_id)
    # comment_params = Map.put(comment_params,"article_id",id)
    IO.inspect(comment_params)
    # IO.inspect Chats.create_comment(comment_params)
    # conn
    # |> put_flash(:info, "Comment created successfully.")
    # |> redirect(to: Routes. article_comment_path(conn, :show, comment.article_id, comment.id))
    # IO.inspect comment_params.article_id
    # , comment_params.article_id, comment_params.id
    case Chats.create_comment(comment_params) do
      {:ok, body} ->
        IO.inspect(body.id)
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: Routes. article_comment_path(conn, :show, body.article_id, body.id))

    #   {:error, %Ecto.Changeset{} = changeset} ->
    #     IO.inspect("Errrorrr")
    #     # IO.inspect(article_id)
    #     # IO.inspect("comment")
    #     # IO.inspect(comment)
    #     # render(conn, "new.html", comment: comment)
    end
  end
  # %{"id" => id}, %{"message" => message, "article_id" => article_id}
  def show(conn, %{"id" => id} ) do
    IO.inspect("+++++++++++Show+++++++++++++")
    # IO.inspect(article_id)
    # IO.inspect(message)

    comment = Chats.get_comment!(id)
    IO.inspect(comment.article_id)
    render(conn, "show.html", comment: comment)
  end

  def edit(conn, %{"id" => id}) do
    comment = Chats.get_comment!(id)
    changeset = Chats.change_comment(comment)
    render(conn, "edit.html", comment: comment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Chats.get_comment!(id)

    case Chats.update_comment(comment, comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment updated successfully.")
        |> redirect(to: Routes. article_comment_path(conn, :show, comment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", comment: comment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Chats.get_comment!(id)
    {:ok, _comment} = Chats.delete_comment(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: Routes.article_comment_path(conn, :index))
  end
end
