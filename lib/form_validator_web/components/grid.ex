defmodule FormValidatorWeb.Components.Column do
  use Surface.Component, slot: "cols"

  @moduledoc """
  the `slot:` option in use Surface.Component above has effect of creating an
  assigns for @cols.  This component doesn't render by itself, but allows this
  renderless component to contain data that can be used inside a parent component
  that will render it.  Each <Column field="artist" /> component rendered within
  a parent <Grid> allows us to declaratively specify the columns in a grid.
  """
  @doc "The field to be rendered"
  prop field, :string, required: true
end

defmodule FormValidatorWeb.Components.Grid do
  use Surface.Component

  @doc "The list of items to be rendered"
  prop items,
       :list,
       required: true,
       default:
         albums = [
           %{name: "The Dark Side of the Moon", artist: "Pink Floyd", released: "March 1, 1973"},
           %{name: "OK Computer", artist: "Radiohead", released: "June 16, 1997"},
           %{
             name: "Disraeli Gears",
             artist: "Cream",
             released: "November 2, 1967",
             selected: true
           },
           %{name: "Physical Graffiti", artist: "Led Zeppelin", released: "February 24, 1975"}
         ]

  @doc "The list of columns defining the Grid"
  slot cols

  def render(assigns) do
    ~F"""
    <table class="table is-bordered is-striped is-hoverable is-fullwidth">
      <thead>
        <tr>
          {#for col <- @cols}
            <th>{Phoenix.Naming.humanize(col.field)}</th>
          {/for}
        </tr>
      </thead>
      <tbody>
        {#for item <- @items}
          <tr>
            {#for col <- @cols, field = String.to_atom(col.field)}
              <td>{item[field]}</td>
            {/for}
          </tr>
        {/for}
      </tbody>
    </table>
    """
  end
end

# <tr class={"is-selected": item[:selected]}>
#   {#for col <- @cols, field = String.to_atom(col.field)}
#     <td>{item[field]}</td>
#   {/for}
# </tr>
