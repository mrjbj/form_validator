defmodule FormValidatorWeb.TestLive do
  use FormValidatorWeb, :surface_view

  import Ash.Query

  import FormValidatorWeb.TweetComponent
  import FormValidatorWeb.TweetListComponent
  import FormValidatorWeb.SlotTestComponent

  alias Ash.Query
  alias AshPhoenix.Form
  alias FormValidator.{User, Address, Api}

  alias Surface.Components.Form.{Label, Field, TextInput}

  # def mount(%{"post_id" => post_id}, _session, socket) do
  def mount(_params, _session, socket) do
    {:ok, user} =
      User
      |> Query.for_read(:via_email, email: "james@marfugi.com")
      |> Query.load(:tweets)
      |> Api.read_one()

    form =
      user
      |> AshPhoenix.Form.for_update(
        :manage_tweets,
        api: Api,
        forms: [auto?: true]
      )

    {:ok, assign(socket, :user, form)}
  end

  # In order to use the `add_form` and `remove_form` helpers, you
  # need to make sure that you are validating the form on change
  def handle_event("validate", %{"form" => params}, socket) do
    form = AshPhoenix.Form.validate(socket.assigns.user, params, errors: false)
    {:noreply, assign(socket, :user, form)}
  end

  def handle_event("save", _params, socket) do
    case AshPhoenix.Form.submit(socket.assigns.user) do
      {:ok, new_user} ->
        {:noreply,
         socket
         |> put_flash(:info, "User created.")
         |> push_redirect(to: "/ash")}

      {:error, form} ->
        assign(socket, :user, form)
    end
  end

  def handle_event("add_form", %{"path" => path}, socket) do
    IO.inspect(path, label: "path in add_form event")
    form = AshPhoenix.Form.add_form(socket.assigns.user, path)
    {:noreply, assign(socket, :user, form)}
  end

  # def handle_event("remove_form", %{"path" => path}) do
  #   form = AshPhoenix.Form.remove_form(socket.assigns.form, path)
  #   {:noreply, assign(socket, :form, form)}
  #          <%= text_input(tweet_form, :body, class: "w-full py-2") %>
  # end

  def render(assigns) do
    ~F"""
    <Label text="Label time!" />

    <Surface.Components.Form
      for={:user}
      change="validate"
      submit="save"
      id="form_user_tweets"
      opts={autocomplete: "off"}
    >
      <Field name="email">
        <TextInput value={@user.data.email} />
      </Field>
      <Field name="username">
        <TextInput value={@user.data.username} />
      </Field>
    </Surface.Components.Form>
    """
  end
end
