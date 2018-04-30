defmodule BarcodeService.Barcodes do
  @moduledoc """
  The Barcodes context.
  """

  def create_barcodes!(barcodes_data) do
    Enum.map(barcodes_data, fn barcode ->
      case create_barcode(barcode["type"], barcode["value"],
          barcode["output_format"]) do
        {:ok, encoded_barcode} ->
          Map.merge(barcode, %{"barcode_data" => encoded_barcode})
        {:error, message} ->
          Map.merge(barcode, %{error: message})
      end
    end)
  end

  def create_barcode("code_128", value, format) when not is_nil(format) do
    file_name = "#{System.tmp_dir()}/#{Ecto.UUID.generate}"
    Barlix.Code128.encode!(value)
    |> Barlix.PNG.print(file: file_name)

    encoded_barcode = :base64.encode(File.read!(file_name))
    File.rm! file_name
    {:ok, encoded_barcode}
  end

  def create_barcode("qr_code", value, format) when not is_nil(format) do
    encoded_barcode = :qrcode.encode(value)
    |> :qrcode_demo.simple_png_encode
    |> :base64.encode

    {:ok, encoded_barcode}
  end

  def create_barcode(_, _, nil), do: {:error, "Output format not specified."}
  def create_barcode(_, _, _), do: {:error, "Unsupported barcode type."}
end
