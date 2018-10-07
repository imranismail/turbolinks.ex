defmodule TurbolinksTest do
  use ExUnit.Case
  use Plug.Test
  use Turbolinks
  doctest Turbolinks

  describe "redirect/2" do
    test "returns the conn with Turbolinks.clearCache() when POST method and XHR request" do
      conn =
        conn(:post, "/", "")
        |> put_req_header("x-requested-with", "XMLHttpRequest")
        |> redirect(to: "/url")

      assert conn.request_path == "/"
      assert conn.resp_body == "Turbolinks.clearCache();\nTurbolinks.visit('/url');\n"
      assert conn.status == 302
    end

    test "returns the conn without Turbolinks.clearCache() when GET method and XHR request" do
      conn =
        conn(:get, "/")
        |> put_req_header("x-requested-with", "XMLHttpRequest")
        |> redirect(to: "/url")

      assert conn.request_path == "/"
      assert conn.resp_body == "Turbolinks.visit('/url');\n"
      assert conn.status == 302
    end

    test "calls the Phoenix.Controller.redirect/2 when not XHR request" do
      conn =
        conn(:get, "/")
        |> redirect(to: "/url")

      assert conn.request_path == "/"

      assert conn.resp_body ==
               "<html><body>You are being <a href=\"/url\">redirected</a>.</body></html>"

      assert Enum.member?(conn.resp_headers, {"content-type", "text/html; charset=utf-8"})
      assert Enum.member?(conn.resp_headers, {"location", "/url"})
      assert conn.status == 302
    end
    
    test "returns the conn with status 308 if :xhr_status is 308" do
      conn =
        conn(:post, "/", "")
        |> put_req_header("x-requested-with", "XMLHttpRequest")
        |> redirect(to: "/url", xhr_status: 308)

      assert conn.status == 308
    end
  end

  describe "js/2 returns the conn" do
    setup do
      conn =
        conn(:post, "/", "")
        |> put_req_header("x-requested-with", "XMLHttpRequest")
        |> put_status(302)

      {:ok, conn: conn}
    end

    test "with response header content-type: application/javascript", %{conn: conn} do
      conn = js(conn, "Turbolinks.visit('/url');")

      assert Enum.member?(
               conn.resp_headers,
               {"content-type", "application/javascript; charset=utf-8"}
             )
    end

    test "with response body containing the passed data", %{conn: conn} do
      conn = js(conn, "Turbolinks.visit('/url');")

      assert conn.resp_body == "Turbolinks.visit('/url');"
    end

    test "with status code of the passed conn", %{conn: conn_before} do
      conn = js(conn_before, "Turbolinks.visit('/url');")

      assert conn.status == conn_before.status
    end

    test "with status code 200 if the passed conn has no status" do
      conn_before =
        conn(:get, "/")
        |> put_req_header("x-requested-with", "XMLHttpRequest")

      conn = js(conn_before, "Turbolinks.visit('/url');")

      assert conn_before.status == nil
      assert conn.status == 200
    end
  end

  describe "xhr?/2" do
    test "returns true if request header 'x-requested-with' contains 'xmlhttprequest'" do
      assert conn(:post, "/", "")
             |> put_req_header("x-requested-with", "XMLHttpRequest")
             |> xhr?()
    end

    test "returns false if there's no request header 'x-requested-with'" do
      refute conn(:get, "/")
             |> xhr?()
    end
  end
end
