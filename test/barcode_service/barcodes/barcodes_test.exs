defmodule BarcodeService.BarcodesTest do
  use BarcodeService.DataCase

  alias BarcodeService.Barcodes

  describe "barcodes" do
    @valid_attrs %{"type" => "code_128", "value" => "my barcode"}

    test "create_barcode/2 creates a base64 encoded barcode" do
      %{"type" => type, "value" => value} = @valid_attrs
      {:ok, data } = Barcodes.create_barcode(type, value)
      assert String.length(data["barcode_data"]) > 0
      assert String.length(data["barcode_data_format"]) > 0
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
