defmodule FormValidatorWeb.TweetListComponent do
  use Phoenix.Component

  import PetalComponents.Table
  import Phoenix.HTML.Form
  import FormValidatorWeb.TweetComponent

  def tweetlist(assigns) do
    ~H"""
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
              <pre>
              hello world
              </pre>
            </.table>
          </div>
        </div>
      </div>
    </div>
    """
  end
end

# <%= for tweet_form <- inputs_for(f, :tweets) do %>
#   <.tweet tweet_form={tweet_form} , id={tweet_form.id} , name={tweet_form.name} />
# <% end %>
