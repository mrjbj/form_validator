defmodule FormValidator.AshTest do
  use FormValidator.DataCase

  require Ash.Query
  import FormValidator.UserFixture
  alias FormValidator.{User, Addresss, Api}
  alias Ash.Changeset

  describe "users" do
    test "user_fixture creates james marfugi by default" do
      user = user_fixture()
      assert user.email == "james@marfugi.com"
    end

    test "user_fixture writes to database" do
      user = user_fixture()

      user2 =
        User
        |> Ash.Query.for_read(:get_by_email, %{email: "james@marfugi.com"})
        |> Api.read_one!()

      assert user2 == user
    end
  end
end
