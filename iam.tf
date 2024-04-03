resource "aws_iam_role" "sfn" {
  name = "${var.project}-snf-exec"
  path = "/"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "states.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "policy_1" {

  role       = aws_iam_role.sfn.name
  policy_arn = aws_iam_policy.snf_policy.arn
}

resource "aws_iam_policy" "snf_policy" {
  name        = "${var.project}-snf-policy"
  path        = "/"
  description = "AWS Step Functions role to invoke lambda for batch logs ingestion."

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Sid" = "InvokeLambda"
        Action = [
          "lambda:InvokeFunction",
        ]
        Effect   = "Allow"
        Resource = "${module.lambda_batch_ingestion.lambda_function_arn}:*"
      },
      {
        "Sid" = "ListObjectsProcess"
        Action = [
          "s3:ListBucket",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${var.bucket_name}"
      },
      {
        "Sid" = "StartStepFunctionsExec"
        Action = [
          "states:StartExecution",
          "states:DescribeExecution",
          "states:StopExecution",
          "events:PutTargets",
          "events:PutRule",
          "events:DescribeRule"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        "Sid" = "xray"
        Action = [

          "xray:PutTraceSegments",
          "xray:PutTelemetryRecords",
          "xray:GetSamplingRules",
          "xray:GetSamplingTargets"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "lambda_exec" {

  name        = "${var.project}-lambda-exec"
  path        = "/service-role/"
  description = "Lambda execution role to send Logs from S3 to Opensearch"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Sid" = "s3"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = ["arn:aws:s3:::${var.bucket_name}", "arn:aws:s3:::${var.bucket_name}/*"]
      },
      {
        "Sid"  = "cloudwatch",
        Effect = "Allow",
        Action = [
          "logs:CreateLogStream",
          "logs:CreateLogGroup",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      },
    ]
  })
}