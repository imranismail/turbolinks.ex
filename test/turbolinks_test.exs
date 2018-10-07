defmodule TurbolinksTest do
  use ExUnit.Case
  use Plug.Test
  use Turbolinks
  doctest Turbolinks

  describe "redirect/2" do
    test "returns the conn with status 308 if :xhr_status is 308" do
      conn =
        conn(:post, "/", "")
        |> put_req_header("x-requested-with", "XMLHttpRequest")
        |> redirect(to: "/url", xhr_status: 308)

      assert conn.status == 308
    end
  end
end
