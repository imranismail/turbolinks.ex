# Turbolinks

[![Hex Downloads](https://img.shields.io/hexpm/dt/turbolinks.svg)](https://hex.pm/packages/turbolinks)
[![Hex Version](https://img.shields.io/hexpm/v/turbolinks.svg)](https://hex.pm/packages/turbolinks)

[Docs](https://hexdocs.pm/turbolinks)

## Motive
> When you visit location /one and the server redirects you to location /two, you expect the browser’s address bar to display the redirected URL.

> However, Turbolinks makes requests using XMLHttpRequest, which transparently follows redirects. There’s no way for Turbolinks to tell whether a request resulted in a redirect without additional cooperation from the server.

> To work around this problem, send the Turbolinks-Location header in response to a visit that was redirected, and Turbolinks will replace the browser’s topmost history entry with the value you provide.

[source](https://github.com/turbolinks/turbolinks#following-redirects)

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

## Redirecting After a Form Submission

Turbolinks module imports a `redirect/2` function with API parity with phoenix's `redirect/2` function. This provides progressive enhancement when we submit a form with XHR.

More details can be found [here](https://github.com/turbolinks/turbolinks#redirecting-after-a-form-submission)

## Unobtrusive JavaScript

TODO
