defmodule FormValidatorWeb.PageLiveTest do
  use FormValidatorWeb.ConnCase

  import Phoenix.LiveViewTest

  @create_attrs %{
    username: "JasonJones",
    email: "jason@brucejones.biz",
    password: "Dont4get,jb"
  }

  @invalid_attrs %{
    username: nil,
    email: nil,
    password: nil
  }

  test "renders form title", %{conn: conn} do
    {:ok, _page_live, html} = live(conn, "/")

    assert html =~ "Create Account"
  end

  test "saves new account", %{conn: conn} do
    {:ok, page_live, _html} = live(conn, "/")

    assert page_live
           |> form("#user-form", user: @invalid_attrs)
           |> render_change() =~ "can&#39;t be blank"

    {:ok, _, html} =
      page_live
      |> form("#user-form", user: @create_attrs)
      |> render_submit()
      |> follow_redirect(conn, "/")

    assert html =~ "User created."
  end

  test "validates email", %{conn: conn} do
    invalid_email = %{email: "email"}
    {:ok, page_live, _html} = live(conn, "/")

    assert page_live
           |> form("#user-form", user: invalid_email)
           |> render_change() =~ "must have the @ sign and no spaces"
  end

  test "validates username", %{conn: conn} do
    {:ok, page_live, _html} = live(conn, "/")

    assert page_live
           |> form("#user-form", user: %{username: "a"})
           |> render_change() =~ "should be at least 5 character(s)"

    assert page_live
           |> form("#user-form", user: %{username: "$%"})
           |> render_change() =~
             "Please use only letters or numbers without spaces (characters _ and - are allowed)"
  end

  test "validates password", %{conn: conn} do
    {:ok, page_live, _html} = live(conn, "/")

    assert page_live
           |> form("#user-form", user: %{password: "a"})
           |> render_change() =~ "should be at least 6 character(s)"

    assert page_live
           |> form("#user-form", user: %{password: "."})
           |> render_change() =~
             "must have at least one lower case character"

    assert page_live
           |> form("#user-form", user: %{password: "."})
           |> render_change() =~
             "must have at least one UPPER case character"

    assert page_live
           |> form("#user-form", user: %{password: "."})
           |> render_change() =~
             "must have at least one digit or punctuation character"
  end
end
