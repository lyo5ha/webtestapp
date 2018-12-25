defmodule WebtestappWeb.Router do
  use WebtestappWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WebtestappWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/payments", PaymentController, only: [:new, :create]
    # get "/payments", PaymentController, :new
    # get "/payments", PaymentController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", WebtestappWeb do
  #   pipe_through :api
  # end
end
