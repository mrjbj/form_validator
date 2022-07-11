
defmodule FormValidatorWeb.Components.ExampleComponent.Example01 do
  @moduledoc """
  Example using the `name` and `subtitle` properties.
  """

  use Surface.Catalogue.Example,
    subject: FormValidatorWeb.Components.ExampleComponent,
    height: "480px",
    title: "Name & Subtitle"

  alias FormValidatorWeb.Components.ExampleComponent

  def render(assigns) do
    ~F"""
    <ExampleComponent >
       Hello, I am @inner_block content.
    </ExampleComponent>
    """
  end
end
