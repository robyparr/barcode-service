# Barcode Service

A simple barcode generation API service.

## Getting Started

Download dependencies

```
mix deps.get
```

Create database if required

```
mix ecto.create
```

Run tests

```
mix test
```

Run the server

```
mix phx.server
```

## Accessing the API

### Generating Barcodes
`POST /barcodes`

**Request**

```
{
  "barcodes": [
    {
      "type": "code_128",
      "value": "my barcode value",
      "output_format": "png"
    }
  ]
}
```

|Field|Type|Description|
|-----|----|-----------|
|type|string|Type of barcode to generate; one of `code_128` or `qr_code`.|
|value|string|The barcode's value.|
|output_format|string|The format to output the barcode in. Currently only supprots `png`.|

#### Response

```
{
    "has_errors": false,
    "barcodes": [
        {
            "value": "my barcode value",
            "type": "code_128",
            "barcode_data_format": "png",
            "barcode_data": "...snip..."
        }
    ]
}
```

|Field|Type|Description|
|-----|----|-----------|
|has_errors|boolean|True if there were any errors during generation. Errors will be embedded within the barcodes that have errors.|
|barcodes|array|An array of barcodes with the original request data and newly generated data.|
|barcodes.barcode_data|string|Base64-encoded barcode.|