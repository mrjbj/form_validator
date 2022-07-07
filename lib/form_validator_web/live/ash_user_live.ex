defmodule FormValidatorWeb.AshUserLive do
  use FormValidatorWeb, :live_view

  import Ash.Query
  import FormValidatorWeb.TweetComponent

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
    <div class="px-4 sm:px-6 lg:px-8">
      <div class="sm:flex sm:items-center">
        <div class="sm:flex-auto">
          <h1 class="text-xl font-semibold text-gray-900">Users</h1>
          <p class="mt-2 text-sm text-gray-700">
            A list of all of your tweets!
          </p>
        </div>
        <div class="mt-4 sm:mt-0 sm:ml-16 sm:flex-none">
          <button
            type="button"
            class="inline-flex items-center justify-center rounded-md border border-transparent bg-indigo-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 sm:w-auto"
          >
            Add tweet
          </button>
        </div>
      </div>
      <div class="mt-8 flex flex-col">
        <div class="-my-2 -mx-4 overflow-x-auto sm:-mx-6 lg:-mx-8">
          <div class="inline-block min-w-full py-2 align-middle md:px-6 lg:px-8">
            <div class="overflow-hidden shadow ring-1 ring-black ring-opacity-5 md:rounded-lg">
              <table class="min-w-full divide-y divide-gray-300">
                <thead class="bg-gray-50">
                  <tr>
                    <th
                      scope="col"
                      class="py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 sm:pl-6"
                    >
                     ID
                    </th>
                    <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">
                     Tweet
                    </th>
                    <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">
                     Public
                    </th>
                    <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">
                     Created
                    </th>
                    <th scope="col" class="relative py-3.5 pl-3 pr-4 sm:pr-6">
                      <span class="sr-only">Edit</span>
                    </th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-200 bg-white">
                  <!-- More people... -->
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>

    <section class="mt-24 w-1/2 shadow flex flex-col items-center justify-center mx-auto p-6 bg-white">
      <h1 class="text-4xl font-bold italic text-gray-700">
        User and Tweets
      </h1>
      <p class="text-gray-500 font-semibold text-lg mt-6 text-center px-8">
        Showing Users and Tweets for James
      </p>

      <.form let={f} for={@form} phx-change="validate" phx-submit="save" id="form_assign_id">
        <%= for tweet_form <- inputs_for(f, :tweets) do %>
           <.tweet body="Hello" />
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
