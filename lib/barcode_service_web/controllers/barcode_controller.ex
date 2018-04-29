defmodule BarcodeServiceWeb.BarcodeController do
  use BarcodeServiceWeb, :controller

  alias BarcodeService.Barcodes

  action_fallback BarcodeServiceWeb.FallbackController

  def create(conn, %{"barcodes" => barcodes_params}) do
    barcodes = Barcodes.create_barcodes!(barcodes_params)
    has_errors = Enum.any?(barcodes, fn it -> Map.has_key?(it, :error) end)

    conn
    |> put_status(:ok)
    |> render("barcodes.json", barcodes: barcodes, has_errors: has_errors)
  end
end
