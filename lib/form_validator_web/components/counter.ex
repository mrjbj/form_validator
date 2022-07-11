defmodule FormValidatorWeb.Components.Counter do
  use Surface.LiveComponent

  @moduledoc """
  from SurfaceUI tutorial.
  Counter component that has 'data assigns' for component local state.
  Note that :on-[event] directives can only be used in HTML tags, not Components,
  since Components can render more than one DOM element and the binding has to be tied
  to just one, so use HTML elements only instead.
  """

  @doc "Local State Data"
  data count, :integer, default: 0

  prop class, :css_class,
    default:
      "inline-flex items-center px-2.5 py-1.5 border border-transparent text-xs font-medium rounded shadow-sm text-white bg-primary-600 hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500"

  def render(assigns) do
    ~F"""
    <div>
      <h1 class="title">
        {@count}
      </h1>
      <div>
        <button class={@class} :on-click="dec">
          -
        </button>
        <button class={@class} :on-click="inc">
          +
        </button>
      </div>
    </div>
    """
  end

  def handle_event("inc", _value, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end

  def handle_event("dec", _value, socket) do
    {:noreply, update(socket, :count, &(&1 - 1))}
  end
end
