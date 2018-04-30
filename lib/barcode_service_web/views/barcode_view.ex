defmodule BarcodeServiceWeb.BarcodeView do
  use BarcodeServiceWeb, :view
  alias BarcodeServiceWeb.BarcodeView

  def render("barcodes.json", %{barcodes: barcodes, has_errors: has_errors}) do
    %{has_errors: has_errors,
      barcodes: render_many(barcodes, BarcodeView, "barcode.json")}
  end

  def render("barcode.json", %{barcode: barcode}) do
    base_response = %{type: barcode["type"], value: barcode["value"]}

    case Map.has_key?(barcode, :error) do
      true ->
        Map.merge(base_response, %{error: barcode.error})
      false ->
        Map.merge(base_response, %{barcode_data: barcode["barcode_data"],
          output_format: barcode["output_format"]})
    end
  end
end
