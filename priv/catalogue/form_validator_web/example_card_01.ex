defmodule FormValidatorWeb.Components.Card.Example01 do
  use Surface.Catalogue.Example,
    subject: FormValidatorWeb.Components.Card,
    height: "480px",
    title: "Name & Subtitle"

  alias FormValidatorWeb.Components.Card
  alias Surface.Components.Form
  alias Surface.Components.Form.{TextInput, Label, Field}

  def render(assigns) do
    ~F"""
    <Card>
      <:header>
        Header Slot: A simple card component
      </:header>

      Default Slot: This example demonstrates how to create components with multiple slots.
      It defines a <strong>default</strong> slot to hold the card's content
      and two <strong>named slots</strong>: header and footer.

      <:footer>
        <a href="#" class="card-footer-item">Footer Item 1</a>
        <a href="#" class="card-footer-item">Footer Item 2</a>
      </:footer>
    </Card>
    """
  end
end
