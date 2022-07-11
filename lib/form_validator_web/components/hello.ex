defmodule FormValidatorWeb.Components.Hello do
  use Surface.Component

  @moduledoc """
  the first sample component from SurfaceUI tutorial.
  Greets the person whose name you pass.
  """

  prop name, :string, required: true

  def render(assigns) do
    ~F"""
    Hello, {@name}
    """
  end
end
