defmodule FormValidatorWeb.Components.MyButton do
  use Surface.Component

  @moduledoc """
  Stateless button.

  Since stateless, everthing must come in as props, including any events that need to be
  triggered here locally. Events can be triggered here but will be handled by the parent caller.
  Events are passed in as "props" of type event.

  Labels and values are also passed in as propsthat triggers the event passed into it as prop from caller.

  """

  prop label, :string
  prop click, :event, required: true
  prop kind, :string, default: "is-info"

  slot default

  def render(assigns) do
    ~F"""
    <button
      type="button"
      class="inline-flex items-center px-2.5 py-1.5 border border-transparent text-xs font-medium rounded shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
      :on-click={@click}
    >
      <#slot>{@label}</#slot>
    </button>
    """
  end
end
