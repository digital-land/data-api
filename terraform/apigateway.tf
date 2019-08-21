resource "aws_api_gateway_rest_api" "data-api" {
  name = "Data API"
  description = "An API to get organisation-based or date-based results from the data collector"
}

resource "aws_api_gateway_resource" "data-api-resource" {
  rest_api_id = aws_api_gateway_rest_api.data-api.id
  parent_id = aws_api_gateway_rest_api.data-api.root_resource_id
  path_part = "status"
}

resource "aws_api_gateway_method" "data-api-method" {
  rest_api_id = aws_api_gateway_rest_api.data-api.id
  resource_id = aws_api_gateway_resource.data-api-resource.id
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "data-api_integration" {
  rest_api_id = aws_api_gateway_rest_api.data-api.id
  resource_id = aws_api_gateway_resource.data-api-resource.id
  http_method = aws_api_gateway_method.data-api-method.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = aws_lambda_function.data-api-getLatestResults.invoke_arn
}

resource "aws_api_gateway_deployment" "data-api-deployment" {
  rest_api_id = aws_api_gateway_rest_api.data-api.id
  stage_name = "dev"
  depends_on = [
    "aws_api_gateway_method.data-api-method",
    "aws_api_gateway_integration.data-api_integration"
  ]
}

output "new_api_development_url" {
  value = aws_api_gateway_deployment.data-api-deployment.invoke_url
}
