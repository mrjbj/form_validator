defmodule FormValidatorWeb.Components.ExampleComponent do
  @moduledoc """
  A sample component from Surface Getting Started Documentation.
  """
  use Surface.Component

  import FormValidatorWeb.Gettext

  slot default, required: true

  def render(assigns) do
    ~F"""
    <h1><#slot /></h1>
    """
  end
end
