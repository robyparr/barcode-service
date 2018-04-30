defmodule BarcodeService.BarcodesTest do
  use BarcodeService.DataCase

  alias BarcodeService.Barcodes

  describe "barcodes" do
    @valid_attrs %{"type" => "code_128", "value" => "my barcode",
      "output_format" => "png"}

    test "create_barcode/3 creates a base64 encoded barcode" do
      %{"type" => type, "value" => value, "output_format" => format} = @valid_attrs
      {:ok, encoded_barcode} = Barcodes.create_barcode(type, value, format)
      assert String.length(encoded_barcode) > 0
    end

    test "create_barcode/3 returns an error if no format is specified" do
      %{"type" => type, "value" => value} = @valid_attrs
      {:error, message} = Barcodes.create_barcode(type, value, nil)
      assert message == "Output format not specified."
    end

    test "create_barcode/3 returns an error if an unsupported barcode type is specified" do
      %{"value" => value, "output_format" => format} = @valid_attrs
      {:error, message} = Barcodes.create_barcode("bad_type", value, format)
      assert message == "Unsupported barcode type."
    end

    test "create_barcode/3 creates a QR code" do
      %{"value" => value, "output_format" => format} = @valid_attrs
      {:ok, encoded_barcode} = Barcodes.create_barcode("qr_code", value, format)
      assert String.length(encoded_barcode) > 0
    end

    test "create_barcodes!/1 creates multiple base64 encoded barcodes" do
      barcodes_data = [@valid_attrs, @valid_attrs]
      barcodes = Barcodes.create_barcodes!(barcodes_data)

      assert length(barcodes) == 2
      Enum.each(barcodes, fn barcode ->
        assert barcode["value"] == @valid_attrs["value"]
        assert String.length(barcode["barcode_data"]) > 0
      end)
    end
  end
end
