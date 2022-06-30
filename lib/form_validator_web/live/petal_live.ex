defmodule FormValidatorWeb.PetalLive do
  use FormValidatorWeb, :live_view

  alias Ash.Changeset
  alias FormValidator.User

  def mount(_params, _session, socket) do
    user_cs = Changeset.new(User)

    form = AshPhoenix.Form.for_create(User, :create, api: FormValidator.Api, as: "form_params")

    {:ok, assign(socket, form_user: form)}
  end

  @doc """
  1. Event is triggered by phx-change binding in DOM.
  2. It passes in an unvalidated :user map as user_params.
  3. Event handler applies params into a new User changeset,
   then sets socket.action to :validate
   and returns the new changeset back as socket.assigns.changeset
  """
  def handle_event("validate", %{"form_params" => params}, socket) do
    form = AshPhoenix.Form.validate(socket.assigns.form_user, params)

    {:noreply, assign(socket, form_user: form)}
  end

  def handle_event("save", %{"value" => value_params}, socket) do
    {:noreply, socket |> put_flash(:info, "You clicked it, baby!")}
  end

  def handle_event("save", _params, socket) do
    case AshPhoenix.Form.submit(socket.assigns.form_user) do
      {:ok, result} ->
        {:noreply,
         socket
         |> put_flash(:info, "User created.")
         |> push_redirect(to: "/")}

      {:error, form} ->
        {:noreply, assign(socket, :form_user, form)}
    end
  end
end
