defmodule FormValidatorWeb.Components.Grid.Example01 do
  use Surface.Catalogue.Example,
    subject: FormValidatorWeb.Components.Grid,
    height: "480px",
    title: "Name & Subtitle"

  alias FormValidatorWeb.Components.Grid
  alias FormValidatorWeb.Components.Column

  data albums, :list, default: []

#   def mount(socket) do
#     albums = [
#       %{name: "The Dark Side of the Moon", artist: "Pink Floyd", released: "March 1, 1973"},
#       %{name: "OK Computer", artist: "Radiohead", released: "June 16, 1997"},
#       %{
#         name: "Disraeli Gears",
#         artist: "Cream",
#         released: "November 2, 1967",
#         selected: true
#       },
#       %{name: "Physical Graffiti", artist: "Led Zeppelin", released: "February 24, 1975"}
#     ]

#     IO.inspect(albums)
#     {:ok, assign(socket, albums: albums)}
# end


  def render(assigns) do
    ~F"""
    <div>
      <Grid>
        <Column field="name" />
        <Column field="artist" />
        <Column field="released" />
      </Grid>
    </div>
    """
  end
end
