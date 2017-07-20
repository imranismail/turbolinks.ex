defmodule Turbolinks.Helpers do
  @moduledoc """
  Helper functions for using with frameworks
  """

  @doc """
  Custom redirection method to return a turbolinks visit and clearcache
  """
  def redirect(conn, opts) do
    if xhr?(conn) do
      conn
      |> Plug.Conn.put_status(302)
      |> js(turbolinks_resp(opts[:to] || opts[:external], conn.method))
    else
      Phoenix.Controller.redirect(conn, opts)
    end
  end

  @doc """
  Custom js response, great to be used to build hybrid turbolinks app
  """
  def js(conn, data) do
    conn
    |> Plug.Conn.put_resp_content_type(MIME.type("js"))
    |> Plug.Conn.send_resp(conn.status || 200, data)
  end

  def xhr?(conn) do
    conn
    |> Plug.Conn.get_req_header("x-requested-with")
    |> List.first
    |> Kernel.==("XMLHttpRequest")
  end

  defp turbolinks_resp(to, "GET"), do: "Turbolinks.visit('#{to}');"
  defp turbolinks_resp(to, _) do
    """
    Turbolinks.clearCache();
    Turbolinks.visit('#{to}');
    """
  end
end
