resource "aws_iam_role" "data-api-iam" {
  name = "data-api-iam-role"
  assume_role_policy = file("json/assume_role_policy.json")

  # Billing tags
  tags = local.digital_land_tags
}

resource "aws_iam_policy" "data-api-iam-policy" {
  name   = "data-api-iam-policy"
  policy = data.aws_iam_policy_document.data-api-policy-document.json
  path   = "/"
}

resource "aws_iam_role_policy_attachment" "data-api-iam-policy-attachment" {
  role       = aws_iam_role.data-api-iam.name
  policy_arn = aws_iam_policy.data-api-iam-policy.arn
}

data "aws_iam_policy_document" "data-api-policy-document" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }

  # statement {
  #   effect = "Allow"

  #   actions = [
  #     "dynamodb:BatchWriteItem",
  #     "dynamodb:DescribeStream",
  #     "dynamodb:GetRecords",
  #     "dynamodb:GetShardIterator",
  #     "dynamodb:ListStreams",
  #     "dynamodb:Query",
  #     "dynamodb:UpdateItem"
  #   ]

  #   resources = [
  #     aws_dynamodb_table.validator_brownfield_sites_dynamodb.arn,
  #     "${aws_dynamodb_table.validator_brownfield_sites_dynamodb.arn}/index/*",
  #     aws_dynamodb_table.validator_brownfield_sites_dynamodb.stream_arn
  #   ]
  # }

  # statement {
  #   effect = "Allow"

  #   actions = [
  #     "s3:*"
  #   ]

  #   resources = [
  #     "${aws_s3_bucket.validator_brownfield_sites_s3.arn}/*"
  #   ]
  # }
}
