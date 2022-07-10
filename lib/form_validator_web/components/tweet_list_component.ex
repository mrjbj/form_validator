defmodule FormValidatorWeb.TweetListComponent do
  use Phoenix.Component

  import PetalComponents
  import Phoenix.HTML.Form
  import FormValidatorWeb.TweetComponent

  # editable list component
  # receives list of entries, iterates through each one and
  # renders the markup specified in the inner block provided
  # by caller.

  @table "min-w-full divide-y divide-gray-300"
  @table_head "min-w-full divide-y divide-gray-300"
  @table_head_row_left "whitespace-nowrap py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 sm:pl-6"
  @table_head_row_rest "whitespace-nowrap px-2 py-3.5 text-left text-sm font-semibold text-gray-900"

  @table_body "divide-y divide-gray-200 bg-white"
  @table_body_left "whitespace-nowrap py-2 pl-4 pr-3 text-sm text-gray-500 sm:pl-6"
  @table_body_rest "whitespace-nowrap px-2 py-2 text-sm text-gray-900"

  defp get_class(class) do
    case class do
      :table -> @table
      :table_head -> @table_head
      :table_head_row_left -> @table_head_row_left
      :table_head_row_rest -> @table_body_rest
      :table_body -> @table_body
      :table_body_left -> @table_body_left
      :table_body_rest -> @table_body_rest
      _ -> ""
    end
  end

  def tweetlist(assigns) do
    ~H"""
    <table>
      <%= render_slot(@table_header) %>
      <tbody>
        <%= for entry <- @entries do %>
          <.tweet tweet_form={entry} />
        <% end %>
      </tbody>
    </table>
    """
  end
end
