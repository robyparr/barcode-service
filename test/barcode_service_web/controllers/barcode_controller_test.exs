defmodule BarcodeServiceWeb.BarcodeControllerTest do
  use BarcodeServiceWeb.ConnCase

  @create_attrs [%{"type" => "code_128", "value" => "my barcode"}]
  @invalid_attrs [%{"type" => "code_bad", "value" => "my barcode"}]

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create barcodes" do
    test "renders barcode when data is valid", %{conn: conn} do
      conn = post conn, barcode_path(conn, :create), barcodes: @create_attrs
      %{"type" => type, "value" => value} = Enum.fetch!(@create_attrs, 0)

      assert %{
        "has_errors" => false,
        "barcodes" => [%{
          "type" => ^type,
          "value" => ^value,
          "barcode_data" => encoded_barcode_data,
          "barcode_data_format" => barcode_data_format
        }]
      } = json_response(conn, 200)
      assert String.length(encoded_barcode_data) > 0
      assert String.length(barcode_data_format) > 0
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, barcode_path(conn, :create), barcodes: @invalid_attrs
      assert %{
        "has_errors" => true,
        "barcodes" => [%{
          "error" => message
        }]
      } = json_response(conn, 200)
      assert String.length(message) > 0
    end
  end
end
