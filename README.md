# Turbolinks

[![Hex Downloads](https://img.shields.io/hexpm/dt/turbolinks.svg)](https://hex.pm/packages/turbolinks)
[![Hex Version](https://img.shields.io/hexpm/v/turbolinks.svg)](https://hex.pm/packages/turbolinks)

[Docs](https://hexdocs.pm/turbolinks)

## Installation
Add Turbolinks to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:turbolinks, "~> 0.1.0"}]
end
```

## Usage with Phoenix

in `/web/web.ex`
```diff
defmodule MyApp.Web do
  def controller do
    quote do
--    use Phoenix.Controller
++    use Turbolinks
      import MyApp.Router.Helpers
      import MyApp.Gettext
    end
  end
end
```

