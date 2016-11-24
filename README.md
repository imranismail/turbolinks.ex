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

in `/web/router.ex`
```diff
defmodule MyApp.Router
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
++  plug Turbolinks
  end
end
```

## Handling Redirects

Turbolinks module imports a `redirect/2` function with API parity with phoenix's `redirect/2` function. This provides progressive enhancement when the request is xhr.

