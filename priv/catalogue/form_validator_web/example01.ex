defmodule FormValidatorWeb.Components.Hero.Example01 do
  @moduledoc """
  Example using the `name` and `subtitle` properties.
  """

  use Surface.Catalogue.Example,
    subject: FormValidatorWeb.Components.Hero,
    height: "480px",
    title: "Name & Subtitle"

  alias FormValidatorWeb.Components.Hero

  def render(assigns) do
    ~F"""
    <Hero subtitle="How are you?"/>
    <Hero
      name="John Doe"
      subtitle="Welcome to Surface!"
    />
    """
  end
end

defmodule FormValidatorWeb.Components.Hello.Example01 do
  @moduledoc """
  Example using the `name` and `subtitle` properties.
  """

  use Surface.Catalogue.Example,
    subject: FormValidatorWeb.Components.Hello,
    height: "480px",
    title: "Name & Subtitle"

  alias FormValidatorWeb.Components.Hello

  def render(assigns) do
    ~F"""
    <Hello name="Dude." />
    """
  end
end
