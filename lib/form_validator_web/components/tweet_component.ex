defmodule FormValidatorWeb.TweetComponent do
  use Phoenix.Component

  import Phoenix.HTML.Form
  # <p>This is a Tweet. The message is <%= @body %>.</p>
  def tweet(assigns) do
    ~H"""
    <tr id={AshPhoenix.Form.value(@tweet_form.source, :id)}>
      <td class="whitespace-nowrap px-2 py-3.5 text-sm text-gray-500">
        <%= @id %>
      </td>
      <td class="whitespace-nowrap px-2 py-3.5 text-sm text-gray-500">
        <%= @name %>
      </td>
      <td class="whitespace-nowrap py-3.5 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6">
        <%= text_input(@tweet_form, :public) %>
      </td>
      <td class="whitespace-nowrap px-2 py-3.5 text-sm text-gray-500">
        <%= text_input(@tweet_form, :body) %>
      </td>
      <td class="whitespace-nowrap px-2 py-3.5 text-sm text-gray-500">
        <%= input_value(@tweet_form, :inserted_at) %>
      </td>
      <td class="whitespace-nowrap px-2 py-3.5 text-sm text-gray-500">
        <%= input_value(@tweet_form, :updated_at) %>
      </td>
      <td class="relative whitespace-nowrap py-2 pl-3 pr-4 text-right text-sm font-medium sm:pr-6">
        <a href="#" class="text-indigo-600 hover:text-indigo-900">
          Edit<span class="sr-only">, Lindsay Walton</span>
        </a>
      </td>
    </tr>
    """
  end
end

# when you want the render the output in HTML, then you need the <%= %>
# when you want to pass an expression from within HEEX to another component, you use {}
# when calling a component, like <.tweet tweet_form = {foo} />, the "assigns" parameter
#   in your components's rendering method will have the properties you passed into it
#   attached to that assignes (e.g. assigns.tweet_form).  Therefore, to access its values
#   you can just reference the property prefixed by the "assigns" operator (e.g. @tweet_form)
