defmodule FormValidatorWeb.TweetComponent do
  use Phoenix.Component

  import Phoenix.HTML.Form
  # renders a tweet.
  # tweet_form is an AshPhoenix.Form
  # fields are expected to be [:public, :body, :inserted_at, :updated_at]

  @row_style "whitespace-nowrap px-2 py-2 text-sm font-medium text-gray-900 sm:pl-6"
  @cell_style "whitespace-nowrap py-2 text-sm font-medium text-gray-900 sm:pl-6"

  defp row_style do
    @row_style
  end

  defp cell_style do
    @cell_style
  end

  def tweet(assigns) do
    ~H"""
    <tr id={AshPhoenix.Form.value(@tweet_form.source, :id)} , class={row_style()}>
      <td class={cell_style()}>
        <%= text_input(@tweet_form, :public) %>
      </td>
      <td class={cell_style()}>
        <%= text_input(@tweet_form, :body) %>
      </td>
      <td class={cell_style()}>
        <%= input_value(@tweet_form, :inserted_at) %>
      </td>
      <td class={cell_style()}>
        <%= input_value(@tweet_form, :updated_at) %>
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

# when you want the render the output in HTML, then you need the <%= %>
# when you want to pass an expression from within HEEX to another component, you use {}
# when calling a component, like <.tweet tweet_form = {foo} />, the "assigns" parameter
#   in your components's rendering method will have the properties you passed into it
#   attached to that assignes (e.g. assigns.tweet_form).  Therefore, to access its values
#   you can just reference the property prefixed by the "assigns" operator (e.g. @tweet_form)
#
# <%= %> means to run elixir code dynamically within a HEEX template.
# {} means to run elixir code dynamically within a tag (e.g. '<>' like live_component or html_element)
#    <div id={"user_#{@id}"}>
#    or <.table id={"hello"} >
# @ means to reference an assigns variable from within a HEEX template.
