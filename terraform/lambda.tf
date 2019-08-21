provider "archive" {}

data "archive_file" "data-api-zip" {
  type        = "zip"
  output_path = "./handler.zip"
  source_dir  = "../src"
}

resource "aws_lambda_function" "data-api-getLatestResults" {
  function_name = "data-api-getLatestResults"
  filename = data.archive_file.data-api-zip.output_path
  source_code_hash = data.archive_file.data-api-zip.output_base64sha256
  role = aws_iam_role.data-api-iam.arn
  handler = "handler.getLatestResults"
  runtime = "nodejs10.x"
  description = "Fetches the latest Data Collector results from DynamoDB"
  timeout = 30

  # Billing tags
  tags = local.digital_land_tags
}

resource "aws_lambda_permission" "data-api-getLatestResults" {
  # The action this permission allows is to invoke the function
  action = "lambda:InvokeFunction"

  # The name of the lambda function to attach this permission to
  function_name = "${aws_lambda_function.data-api-getLatestResults.arn}"

  # An optional identifier for the permission statement
  statement_id = "AllowExecutionFromApiGateway"

  # The item that is getting this lambda permission
  principal = "apigateway.amazonaws.com"

  # /*/*/* sets this permission for all stages, methods, and resource paths in API Gateway to the lambda
  # function. - https://bit.ly/2NbT5V5
  source_arn = "${aws_api_gateway_rest_api.data-api.execution_arn}/*/*/*"
}
