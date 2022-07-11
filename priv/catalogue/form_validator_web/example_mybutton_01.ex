defmodule FormValidatorWeb.Components.MyButton.Example01 do
  @moduledoc """
  Shows parent form that has state for variable "count"
  Also calls child component <MyButton> and passes it the
  events it should call when pressed.  Since MyButton is stateless
  function component, the event handler is here in the parent.
  """

  use Surface.Catalogue.Example,
    subject: FormValidatorWeb.Components.MyButton,
    height: "480px",
    title: "Name & Subtitle"


  data count, :integer, default: 0

  alias FormValidatorWeb.Components.MyButton

  def render(assigns) do
    ~F"""
    <div>
    <p>Clicked <strong>{@count}</strong> time(s)</p>
    <MyButton label="Click!" click="clicked" />
    <MyButton label="Reset" click="reset" />
    </div>
    """
  end

  def handle_event("clicked", _value, socket) do
    {:noreply, update(socket, :count, &(&1 +1))}
    end
  def handle_event("reset", _value, socket) do
    {:noreply, update(socket, :count, fn x -> 0 end)}
    end
 end
