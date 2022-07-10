defmodule FormValidatorWeb.SlotTestComponent do
  use Phoenix.Component

  import Phoenix.HTML.Form

  def slottest(assigns) do
    ~H"""
    <button class="btn">
      <%= render_slot(@inner_block) %>
    </button>
    """
  end
end

# when you want the render the output in HTML, then you need the <%= %>
# when you want to pass an expression from within HEEX or HTML tag to another component, you use {}
# when calling a component, like <.tweet tweet_form = {foo} />, the "assigns" parameter
#   in your components's rendering method will have the properties you passed into it
#   attached to that assignes (e.g. assigns.tweet_form).  Therefore, to access its values
#   you can just reference the property prefixed by the "assigns" operator (e.g. @tweet_form)
#
# <%= %> means to run elixir code dynamically within a HEEX template.
# {} means to run elixir code dynamically within a tag (e.g. '<>' like live_component or html_element)
#    <div id={"user_#{@id}"}>
#    or <.table id={"hello"} >
# @ means to reference an assigns variable from within a HEEX template.
