defmodule FormValidator.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password])
    |> validate_required([:email, :username, :password])
    |> validate_email()
    |> validate_username()
    |> validate_password()
  end

  defp validate_email(changeset) do
    changeset
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
  end

  defp validate_username(changeset) do
    changeset
    |> validate_format(:username, ~r/^[a-zA-Z0-9_.-]*$/,
      message:
        "Please use only letters or numbers without spaces (characters _ and - are allowed)"
    )
    |> validate_length(:username, min: 5, max: 30)
  end

  defp validate_password(changeset) do
    changeset
    |> validate_length(:password, min: 6, max: 80)
    |> validate_format(:password, ~r/[a-z]/,
      message: "must have at least one lower case character"
    )
    |> validate_format(:password, ~r/[A-Z]/,
      message: "must have at least one UPPER case character"
    )
    |> validate_format(:password, ~r/[!?#$%^&*_0-9]/,
      message: "must have at least one digit or punctuation character"
    )
  end
end
