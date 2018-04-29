defmodule BarcodeService.Barcodes do
  @moduledoc """
  The Barcodes context.
  """

  @barcode_type_mapper %{"code_128" => Barlix.Code128}

  def create_barcodes!(barcodes_data) do
    Enum.map(barcodes_data, fn barcode ->
      case create_barcode(barcode["type"], barcode["value"]) do
        {:ok, data} ->
          Map.merge(barcode, data)
        {:error, message} ->
          Map.merge(barcode, %{error: message})
      end
    end)
  end

  def create_barcode(type, value) do
    case Map.fetch(@barcode_type_mapper, type) do
      {:ok, barcode_type } ->
        file_name = "#{System.tmp_dir()}/#{Ecto.UUID.generate}"
        barcode_type.encode!(value)
        |> Barlix.PNG.print(file: file_name)

        barcode_data = %{
          "barcode_data" => :base64.encode(File.read!(file_name)),
          "barcode_data_format" => "png"
        }
        File.rm! file_name
        {:ok, barcode_data}
      :error ->
        {:error, "Unsupported barcode type."}
    end
  end
end
