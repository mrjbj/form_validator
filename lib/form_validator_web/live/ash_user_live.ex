defmodule FormValidatorWeb.AshUserLive do
  use FormValidatorWeb, :live_view

  import Ash.Query
  alias Ash.Query
  alias AshPhoenix.Form
  alias FormValidator.{User, Address, Api}

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

    {:ok, assign(socket, :form, form)}
  end

  # In order to use the `add_form` and `remove_form` helpers, you
  # need to make sure that you are validating the form on change
  def handle_event("validate", %{"form" => params}, socket) do
    form = AshPhoenix.Form.validate(socket.assigns.form, params, errors: false)
    {:noreply, assign(socket, :form, form)}
  end

  def handle_event("save", _params, socket) do
    case AshPhoenix.Form.submit(socket.assigns.form) do
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
    form = AshPhoenix.Form.add_form(socket.assigns.form, path)
    {:noreply, assign(socket, :form, form)}
  end

  # def handle_event("remove_form", %{"path" => path}) do
  #   form = AshPhoenix.Form.remove_form(socket.assigns.form, path)
  #   {:noreply, assign(socket, :form, form)}
  # end

  def render(assigns) do
    ~H"""
    <section class="mt-24 w-1/2 shadow flex flex-col items-center justify-center mx-auto p-6 bg-white">
      <h1 class="text-4xl font-bold italic text-gray-700">
        User and Tweets
      </h1>
      <p class="text-gray-500 font-semibold text-lg mt-6 text-center px-8">
        Showing Users and Tweets for James
      </p>

      <.form let={f} for={@form} phx-change="validate" phx-submit="save" id="form_assign_id">
        <%= for tweet_form <- inputs_for(f, :tweets) do %>
          <%= text_input(tweet_form, :body, class: "w-full py-2") %>
        <% end %>

        <div>
          <%= submit("Save",
            phx_disable_with: "Saving...",
            class:
              "w-full py-2 border-none shadow rounded font-semibold text-sm text-gray-50 hover:bg-violet-600 bg-violet-500"
          ) %>
        </div>
      </.form>

      <p class="text-sm px-10 text-center mt-6 text-gray-400 font-semibold">
        By signing up, you agree to Terms, Data and Cookies Policy.
      </p>
      <pre>
          Hi, this is a test area for "pre"
          </pre>
    </section>
    """
  end
end
