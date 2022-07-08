defmodule FormValidatorWeb.TweetComponent do
  use Phoenix.Component

  import Phoenix.HTML.Form
  # <p>This is a Tweet. The message is <%= @body %>.</p>
  def tweet(assigns) do
    ~H"""
    <tr id={AshPhoenix.Form.value(@tweet_form.source, :id)}>
      <td class="whitespace-nowrap py-3.5 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6">
        <%= input_value(@tweet_form, :body) %>
      </td>
      <td class="whitespace-nowrap px-2 py-3.5 text-sm text-gray-500"></td>
      <td class="whitespace-nowrap px-2 py-3.5 text-sm text-gray-500"></td>
      <td class="whitespace-nowrap px-2 py-3.5 text-sm text-gray-500">Member</td>
      <td class="relative whitespace-nowrap py-2 pl-3 pr-4 text-right text-sm font-medium sm:pr-6">
        <a href="#" class="text-indigo-600 hover:text-indigo-900">
          Edit<span class="sr-only">, Lindsay Walton</span>
        </a>
      </td>
    </tr>
    """
  end
end
