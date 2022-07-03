defmodule FormValidator.UserFixture do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FormValidator.Accounts` context.
  """

  @doc """
  Generate a user, with defaults, if not provided.
  """
  def user_fixture(attrs \\ %{}) do
    user =
      Enum.into(attrs, %{
        email: "james@marfugi.com",
        password: "Dont4get,jb",
        username: "jamesmf"
      })

    {:ok, result} =
      Ash.Changeset.new(FormValidator.User, user)
      |> FormValidator.Api.create()

    result
  end
end
