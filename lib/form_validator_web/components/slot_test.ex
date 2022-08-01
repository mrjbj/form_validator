defmodule FormValidatorWeb.SlotTestComponent do
  use Surface.Component

  @doc """
  Can pass HTML into slot for custom rendering.
  This test renders a button, so we can specify the button name like so:
  <SlotTestComponent >
      Save
  </SlotTestComponent>
  """

  slot default, required: true

  def render(assigns) do
    ~F"""
    <button class="btn">
      <#slot />
    </button>
    """
  end
end
