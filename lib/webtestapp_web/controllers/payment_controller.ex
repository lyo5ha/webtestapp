defmodule WebtestappWeb.PaymentController do
  require Logger
  use WebtestappWeb, :controller

  def new(conn, _params) do
    render(conn, "index.html", conn: conn)
  end

  def create(conn, _params) do
    logger(_params)
  end

  def logger(something) do
    Logger.warn inspect(something, pretty: true)
    something
  end

end
