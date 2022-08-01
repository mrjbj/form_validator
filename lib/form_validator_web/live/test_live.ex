defmodule FormValidatorWeb.TestLive do
  use FormValidatorWeb, :surface_view

  import Ash.Query
  alias Ash.Query
  alias FormValidator.{User, Address, Api}

  alias AshPhoenix.Form, as: AshForm
  alias Surface.Components.Form, as: Form

  alias FormValidatorWeb.SlotTestComponent, as: Button
  alias FormValidatorWeb.TweetListComponent, as: TweetList
  alias FormValidatorWeb.TweetComponent, as: Tweet

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
         |> push_redirect(to: "/test")}

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
    ~F"""
    <Form.Label text="Label time!" />
    <Button>
      New Button Markup
    </Button>
    <Form :let={form: form} for={@form} change="validate" submit="save" opts={autocomplete: "off"}>
      <TweetList>
        <:header>
          <tr id="table_header">
            <td>Public</td>
            <td>Body</td>
            <td>Inserted</td>
            <td>Updated</td>
            <td>Actions</td>
          </tr>
        </:header>
        {#for entry <- inputs_for(form, :tweets)}
          <Tweet tweet_form={entry} />
        {/for}
      </TweetList>
      {submit("Save",
        phx_disable_with: "Saving...",
        class:
          "w-1/6 py-2 border-none shadow rounded font-semibold text-sm text-gray-50 hover:bg-primary-600 bg-primary-500"
      )}
    </Form>
    """
  end
end

# <Form.Label text="Label time!" />
# <Button>
#   New Button Markup
# </Button>
