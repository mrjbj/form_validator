[
  import_deps: [:ecto, :phoenix, :ash, :ash_phoenix, :ash_postgres, :surface],
  plugins: [Phoenix.LiveView.HTMLFormatter, Surface.Formatter.Plugin],
  inputs: [
  "*.{ex,exs}",
  "priv/*/seeds.exs",
  "{config,lib,test}/**/*.{ex,exs}",
  "{config,lib,test}/**/*.html.heex",
  "{lib,test}/**/*.sface"
],
  subdirectories: ["priv/*/migrations"]
]
