defmodule FormValidatorWeb.ExampleLive do
  use Surface.LiveView

  alias FormValidatorWeb.Components.Hero
  data count, :integer, default: 0

  def render(assigns) do
    ~F"""
    <Hero />
    """
  end

  # Event handlers

  def handle_event("inc", _, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end

  def handle_event("dec", _, socket) do
    {:noreply, update(socket, :count, &(&1 - 1))}
  end

  def handle_event("reset", _, socket) do
    {:noreply, assign(socket, :count, 0)}
  end
end
