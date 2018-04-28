defmodule BarcodeServiceWeb.PageController do
  use BarcodeServiceWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
