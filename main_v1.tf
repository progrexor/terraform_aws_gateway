provider "aws" {
  region  = "us-east-2"
  profile = "default"
}

resource "aws_api_gateway_integration" "api_lambda" {
  http_method             = "ANY"
//  connection_type         = "INTERNET"
//  content_handling        = "CONVERT_TO_TEXT"
//  integration_http_method = "POST"
//  passthrough_behavior    = "WHEN_NO_MATCH"
  resource_id             = aws_api_gateway_resource.ccc.id
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:us-east-2:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-2:416838099276:function:avd-test-api/invocations"
}

resource "aws_api_gateway_method" "api_meth" {
  authorization = "NONE"
  http_method   = "ANY"
  resource_id   = aws_api_gateway_resource.ccc.id
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
}

resource "aws_api_gateway_resource" "ccc" {
  parent_id   = aws_api_gateway_resource.bbb.id
  path_part   = "{ccc}"
  rest_api_id = aws_api_gateway_rest_api.my_api.id
}

resource "aws_api_gateway_resource" "bbb" {
  parent_id   = aws_api_gateway_resource.aaa.id
  path_part   = "{bbb}"
  rest_api_id = aws_api_gateway_rest_api.my_api.id
}

resource "aws_api_gateway_resource" "aaa" {
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "aaa"
  rest_api_id = aws_api_gateway_rest_api.my_api.id
}

resource "aws_api_gateway_rest_api" "my_api" {
  name = "AVD_Test1"
}
