defmodule BarcodeServiceWeb.Router do
  use BarcodeServiceWeb, :router

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

  scope "/admin", BarcodeServiceWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/", BarcodeServiceWeb do
    pipe_through :api

    resources "/barcodes", BarcodeController, only: [:create]
  end
end
