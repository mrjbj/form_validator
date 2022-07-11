defmodule FormValidatorWeb.Components.Counter.Example01 do
  @moduledoc """
  Example for MyButton 
  """

  use Surface.Catalogue.Example,
    subject: FormValidatorWeb.Components.Counter,
    height: "480px",
    title: "Name & Subtitle"

  alias FormValidatorWeb.Components.Counter

  def render(assigns) do
    ~F"""
      <Counter id="dad" />
    """
  end
end
