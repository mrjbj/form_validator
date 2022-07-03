[
  import_deps: [:ecto, :phoenix, :ash, :ash_phoenix, :ash_postgres],
  plugins: [Phoenix.LiveView.HTMLFormatter],
  inputs: [
    "*.{ex,exs}",
    "priv/*/seeds.exs",
    "{config,lib,test}/**/*.{ex,exs}",
    "{config,lib,test}/**/*.html.heex"
  ],
  subdirectories: ["priv/*/migrations"]
]
