defmodule FormValidatorWeb.AshUserLive do
  use FormValidatorWeb, :live_view

  import Ash.Query
  import FormValidatorWeb.TweetComponent
  import FormValidatorWeb.TweetHeader

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
  #          <%= text_input(tweet_form, :body, class: "w-full py-2") %>
  # end

  def render(assigns) do
    ~H"""
    <.form let={f} for={@form} phx-change="validate" phx-submit="save" id="form_assign_id">
      <div class="px-4 sm:px-6 lg:px-8">
        <!-- Container for parent + "export button for children " -->
        <div class="sm:flex sm:items-center">
          <div class="sm:flex-auto">
            <h1 class="text-xl font-semibold text-gray-900">Transactions</h1>
            <p class="mt-2 text-sm text-gray-700">
              A table of placeholder stock market data that does not make any sense.
            </p>
          </div>
          <div class="mt-4 sm:mt-0 sm:ml-16 sm:flex-none">
            <button
              type="button"
              class="inline-flex items-center justify-center rounded-md border border-transparent bg-primary-600 px-8 py-2 text-sm font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 sm:w-auto"
            >
              Export
            </button>
          </div>
        </div>
        <!-- Container + Table . -->
        <div class="mt-8 flex flex-col">
          <div class="-my-2 -mx-4 overflow-x-auto sm:-mx-6 lg:-mx-8">
            <div class="inline-block min-w-full py-2 align-middle md:px-6 lg:px-8">
              <div class="overflow-hidden shadow ring-1 ring-black ring-opacity-5 md:rounded-t-lg">
                <.table class="min-w-full divide-y divide-gray-300">
                  <.tr class="bg-gray-50">
                    <.th>Form ID</.th>
                    <.th>Form Name</.th>
                    <.th>Public?</.th>
                    <.th>Tweet</.th>
                    <.th>Inserted</.th>
                    <.th>Update</.th>
                  </.tr>
                  <%= for tweet_form <- inputs_for(f, :tweets) do %>
                    <.tweet tweet_form={tweet_form} , id={tweet_form.id} , name={tweet_form.name} />
                  <% end %>
                </.table>
              </div>
            </div>
          </div>
        </div>
        <div class="mt-4 px-8 sm:mt-0 sm:ml-16 sm:flex-none flex justify-end">
          <%= submit("Save",
            phx_disable_with: "Saving...",
            class:
              "w-1/6 py-2 border-none shadow rounded font-semibold text-sm text-gray-50 hover:bg-primary-600 bg-primary-500"
          ) %>
        </div>
      </div>
    </.form>
    """
  end
end

# <.tweet tweet_form={tweet_form} , id={tweet_form.id} , name={tweet_form.name} />
