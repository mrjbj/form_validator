defmodule FormValidatorWeb.PetalLive do
  use FormValidatorWeb, :live_view

  alias FormValidator.Accounts
  alias FormValidator.Accounts.User

  def mount(_params, _session, socket) do
    changeset = Accounts.change_user(%User{})

    {:ok, assign(socket, changeset: changeset)}
  end

  @doc """
  1. Event is triggered by phx-change binding in DOM.
  2. It passes in an unvalidated :user map as user_params.
  3. Event handler applies params into a new User changeset,
   then sets socket.action to :validate
   and returns the new changeset back as socket.assigns.changeset
  """
  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      %User{}
      |> Accounts.change_user(user_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"value" => value_params}, socket) do
    IO.inspect(value_params, label: "value_params")

    {:noreply, socket |> put_flash(:info, "You clicked it, baby!")}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Accounts.create_user(user_params) do
      {:ok, _user} ->
        {:noreply,
         socket
         |> put_flash(:info, "User created.")
         |> push_redirect(to: "/")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
