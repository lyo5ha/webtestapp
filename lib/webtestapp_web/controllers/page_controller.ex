defmodule WebtestappWeb.PageController do
  use WebtestappWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
