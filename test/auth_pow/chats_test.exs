defmodule AuthPow.ChatsTest do
  use AuthPow.DataCase

  alias AuthPow.Chats

  describe "comments" do
    alias AuthPow.Chats.Comment

    import AuthPow.ChatsFixtures

    @invalid_attrs %{message: nil}

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Chats.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Chats.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      valid_attrs = %{message: "some message"}

      assert {:ok, %Comment{} = comment} = Chats.create_comment(valid_attrs)
      assert comment.message == "some message"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chats.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      update_attrs = %{message: "some updated message"}

      assert {:ok, %Comment{} = comment} = Chats.update_comment(comment, update_attrs)
      assert comment.message == "some updated message"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Chats.update_comment(comment, @invalid_attrs)
      assert comment == Chats.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Chats.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Chats.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Chats.change_comment(comment)
    end
  end
end
