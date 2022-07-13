defmodule FormValidatorWeb.TestLive do
  use FormValidatorWeb, :surface_view

  import Ash.Query

  import FormValidatorWeb.TweetComponent
  import FormValidatorWeb.TweetListComponent
  import FormValidatorWeb.SlotTestComponent

  alias Ash.Query
  alias AshPhoenix.Form, as: AshForm
  alias FormValidator.{User, Address, Api}

  import Surface.Components.Form
  alias Surface.Components.Form

  # def mount(%{"post_id" => post_id}, _session, socket) do
  def mount(_params, _session, socket) do
    {:ok, user} =
      User
      |> Query.for_read(:via_email, email: "james@marfugi.com")
      |> Query.load(:tweets)
      |> Api.read_one()

    form =
      user
      |> AshForm.for_update(
        :manage_tweets,
        api: Api,
        forms: [auto?: true]
      )

    {:ok, assign(socket, :form, form)}
  end

  # In order to use the `add_form` and `remove_form` helpers, you
  # need to make sure that you are validating the form on change
  def handle_event("validate", %{"form" => params}, socket) do
    form = AshForm.validate(socket.assigns.form, params, errors: false)
    {:noreply, assign(socket, :form, form)}
  end

  def handle_event("save", _params, socket) do
    case AshForm.submit(socket.assigns.form) do
      {:ok, new_user} ->
        {:noreply,
         socket
         |> put_flash(:info, "User created.")
         |> push_redirect(to: "/ash")}

      {:error, form} ->
        assign(socket, :form, form)
    end
  end

  def handle_event("add_form", %{"path" => path}, socket) do
    IO.inspect(path, label: "path in add_form event")
    form = AshForm.add_form(socket.assigns.form, path)
    {:noreply, assign(socket, :form, form)}
  end

  # def handle_event("remove_form", %{"path" => path}) do
  #   form = AshPhoenix.Form.remove_form(socket.assigns.form, path)
  #   {:noreply, assign(socket, :form, form)}
  #          <%= text_input(tweet_form, :body, class: "w-full py-2") %>
  # end

  def render(assigns) do
    AshForm.inputs_for()

    ~F"""
    <Form.Label text="Label time!" />

    <Surface.Components.Form for={:form} change="validate" submit="save" opts={autocomplete: "off"}>
      <Form.Field name={:email}>
        <Form.Label />
        <Form.TextInput opts={phx_debounce: 300} />
      </Form.Field>
      <Form.Field name={:username}>
        <Form.Label />
        <Form.Input opts={phx_debounce: 300} />
      </Form.Field>
      <Form.Field name="username">
        <Form.Label />
        <Form.TextInput value={@form.data.username} />
      </Form.Field>
      <.tweetlist entries={inputs_for(:form, :tweets)}>
        <:table_header>
          <.tr class="bg-gray-50">
            <.th>Public?</.th>
            <.th>Tweet</.th>
            <.th>Inserted</.th>
            <.th>Update</.th>
            <.th>Action</.th>
          </.tr>
        </:table_header>
      </.tweetlist>
    </Surface.Components.Form>
    """
  end
end
