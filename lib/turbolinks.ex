defmodule Turbolinks do
  @moduledoc """
  This plug is built on top of works done by @kagux at https://github.com/kagux/turbolinks_plug

  in `web.ex`
  add `use Turbolinks`

  in `router.ex` add a the plug
  plug Turbolinks
  """

  use Plug.Builder

  import Turbolinks.Helpers

  @session_key "turbolinks_location"
  @original_location_header "location"
  @location_header "turbolinks-location"
  @referrer_header "turbolinks-referrer"

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      import Phoenix.Controller, except: [redirect: 2]
      import Turbolinks.Helpers
    end
  end

  @doc false
  def call(conn, opts) do
    conn
    |> super(opts)
    |> register_before_send(&handle_redirect/1)
    |> put_phoenix_format()
  end

  @doc false
  def handle_redirect(conn) do
    case conn.status do
      status when status in 301..302 ->
        store_location_in_session(conn)
      status when status in 200..299 ->
        conn
        |> get_session(@session_key)
        |> set_location_header(conn)
      _status ->
        conn
    end
  end

  defp store_location_in_session(conn) do
    with [_referrer] <- get_referrer_header(conn),
         [location] <- get_location_header(conn) do
      put_session(conn, @session_key, location)
    else
      [] -> conn
    end
  end

  defp set_location_header(location, conn) do
    if location do
      conn
      |> put_resp_header(@location_header, location)
      |> delete_session(@session_key)
    else
      conn
    end
  end

  defp get_location_header(conn) do
    get_resp_header(conn, @original_location_header)
  end

  defp get_referrer_header(conn) do
    get_req_header(conn, @referrer_header)
  end

  defp put_phoenix_format(conn) do
    if xhr?(conn) do
      Phoenix.Controller.put_format(conn, "js")
    else
      conn
    end
  end
end
