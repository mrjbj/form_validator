defmodule FormValidatorWeb.AshLive do
  use FormValidatorWeb, :live_view

  import Ash.Query
  alias AshPhoenix.Form
  alias FormValidator.{User, Address, Api}

  # def mount(%{"post_id" => post_id}, _session, socket) do
  def mount(_params, _session, socket) do
    user =
      User
      |> Ash.Query.for_read(:get_by_email, %{email: "james@marfugi.com"})
      |> Api.read_one!()
    |> Api.load!(:addresses)

    form = AshPhoenix.Form.for_update(user, api: FormValidator.Api)

    # post =
    #   Post
    #   |> MyApp.MyApi.get!(post_id)
    #   |> MyApi.load!(comments: [:sub_comments])

    # form = AshPhoenix.Form.for_update(post,
    #   api: MyApp.MyApi,
    #   forms: [
    #     comments: [
    #       resource: Comment,
    #       data: post.comments,
    #       create_action: :create,
    #       update_action: :update
    #       forms: [
    #         sub_comments: [
    #           resource: Comment,
    #           data: &(&1.sub_comments),
    #           create_action: :create,
    #           update_action: :update
    #         ]
    #       ]
    #     ]
    #   ])

    {:ok, assign(socket, form: form)}
  end

  # In order to use the `add_form` and `remove_form` helpers, you
  # need to make sure that you are validating the form on change
  def handle_event("validate", %{"form" => params}, socket) do
    form = AshPhoenix.Form.validate(socket.assigns.form, params)

    # You can also skip errors by setting `errors: false` if you only want to show errors on submit
    # form = AshPhoenix.Form.validate(socket.assigns.form, params, errors: false)

    {:ok, assign(socket, :form, form)}
  end

  def handle_event("save", _params, socket) do
    case AshPhoenix.Form.submit(socket.assigns.form) do
      {:ok, _result} ->
        {:noreply,
         socket
         |> put_flash(:info, "User created.")
         |> push_redirect(to: "/")}

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
          Create Account
        </h1>
      
        <p class="text-gray-500 font-semibold text-lg mt-6 text-center px-8">
          Sign up to get an account
        </p>
        <.form let={f} for={@form_user} phx-change="validate" phx-submit="save" id="form_user">
          <.form_field type="email_input" form={f} field={:email} />
          <.form_field type="text_input" form={f} field={:username} />
          <.form_field type="password_input" form={f} field={:password} />
      
          <.dropdown label="Pick One" js_lib="live_view_js">
            <.dropdown_menu_item>
              <Heroicons.Outline.home class="w-5 h-5 text-gray-500" /> Button item with icon
            </.dropdown_menu_item>
            <.dropdown_menu_item link_type="button" label="button item" />
            <.dropdown_menu_item link_type="a" to="/" label="Link" />
            <.dropdown_menu_item link_type="a" to="/" label="Link with method" method={:put} />
            <.dropdown_menu_item link_type="live_patch" to="/" label="Live Patch" />
            <.dropdown_menu_item link_type="live_redirect" to="/" label="Live Redirect" />
            <.dropdown_menu_item phx-click="save" label="Phoenix click event" />
          </.dropdown>
          <div>
            <%= submit("Signup",
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

