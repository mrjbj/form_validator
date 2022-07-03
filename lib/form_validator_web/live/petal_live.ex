defmodule FormValidatorWeb.PetalLive do
  use FormValidatorWeb, :live_view

  import Ash.Query
  alias AshPhoenix.Form
  alias FormValidator.{User, Address, Api}

  def mount(_params, _session, socket) do
    user =
      User
      |> Ash.Query.for_read(:get_by_email, %{email: "james@marfugi.com"})
      |> Api.read_one!()

    {:ok, socket}
    # form = Form.for_create(User, :create,
    #   api: FormValidator.Api,
    #   forms: [
    #     addresses: [
    #       resource: Address,
    #       data:
    #     ]
    #   ]

    # {:ok, assign(socket, form_user: form)}
  end

  @doc """
  1. Event is triggered by phx-change binding in DOM.
  2. It passes in an unvalidated :user map as user_params.
  3. Event handler applies params into a new User changeset,
   then sets socket.action to :validate
   and returns the new changeset back as socket.assigns.changeset
  """
  def handle_event("validate", %{"form_params" => params}, socket) do
    form = Form.validate(socket.assigns.form_user, params)
    {:noreply, assign(socket, form_user: form)}
  end

  def handle_event("save", %{"value" => _value_params}, socket) do
    {:noreply, socket |> put_flash(:info, "You clicked it, baby!")}
  end

  def handle_event("save", _params, socket) do
    case Form.submit(socket.assigns.form_user) do
      {:ok, _result} ->
        {:noreply,
         socket
         |> put_flash(:info, "User created.")
         |> push_redirect(to: "/")}

      {:error, form} ->
        {:noreply, assign(socket, :form_user, form)}
    end
  end
end
