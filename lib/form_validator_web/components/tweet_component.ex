defmodule FormValidatorWeb.TweetComponent do
  use Surface.Component

  import Phoenix.HTML.Form

  @doc """
  renders a tweet.
  tweet_form is an AshPhoenix.Form
  fields are expected to be [:public, :body, :inserted_at, :updated_at]
  """
  slot default, required: true
  prop tweet_form, :struct

  @row_style "whitespace-nowrap px-2 py-2 text-sm font-medium text-gray-900 sm:pl-6"
  @cell_style "whitespace-nowrap py-2 text-sm font-medium text-gray-900 sm:pl-6"

  defp row_style do
    @row_style
  end

  defp cell_style do
    @cell_style
  end

  def render(assigns) do
    ~F"""
    <tr id={AshPhoenix.Form.value(@tweet_form.source, :id)} , class={row_style()}>
      <td class={cell_style()}>
        {text_input(@tweet_form, :public)}
      </td>
      <td class={cell_style()}>
        {text_input(@tweet_form, :body)}
      </td>
      <td class={cell_style()}>
        {input_value(@tweet_form, :inserted_at)}
      </td>
      <td class={cell_style()}>
        {input_value(@tweet_form, :updated_at)}
      </td>
      <td class={cell_style()}>
        <a href="#" class="text-indigo-600 hover:text-indigo-900">
          Edit<span class="sr-only">, Lindsay Walton</span>
        </a>
      </td>
    </tr>
    """
  end
end
