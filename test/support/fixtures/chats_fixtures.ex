defmodule AuthPow.ChatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AuthPow.Chats` context.
  """

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        message: "some message"
      })
      |> AuthPow.Chats.create_comment()

    comment
  end
end
