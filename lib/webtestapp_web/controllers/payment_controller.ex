defmodule WebtestappWeb.PaymentController do
  # require HTTPoison
  require Logger
  use WebtestappWeb, :controller

  def new(conn, _params) do
    render(conn, "index.html", conn: conn)
  end

  def create(conn, _params) do
    redirect_url =
    conn
    |> prepare_request
    |> request
    |> parse_params_for_redirect

    redirect(conn, external: redirect_url)
  end

  defp parse_params_for_redirect({:ok, response}) do
    response.headers
    |> Enum.find(fn tuple -> elem(tuple, 0) == "location" end)
    |> elem(1)
  end

  def logger(something) do
    Logger.warn inspect(something, pretty: true)
    something
  end

  def prepare_request(conn) do
    url = "http://localhost:4001/api"

    headers = [{"Content-Type", "application/json"}]

    body =  Poison.encode! %{
      "id": conn.params["form_params"]["id"],
      "type": conn.params["form_params"]["type"],
      "data": %{
        "payment_system": conn.params["form_params"]["payment_system"],
        "account": %{
          "type": conn.params["form_params"]["account_type"],
          "uid": conn.params["form_params"]["account_uid"]
        },
        "charge": %{
          "currency": conn.params["form_params"]["currency"],
          "fractional": conn.params["form_params"]["fractional"]
        },
        "status": conn.params["form_params"]["status"]
      }
    }

    [url, body, headers]
  end

  def request([url | [body | [headers]]] = params) do
    HTTPoison.post(url, body, headers)
  end
end
