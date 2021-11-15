defmodule AuthPowWeb.PageController do
  use AuthPowWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
