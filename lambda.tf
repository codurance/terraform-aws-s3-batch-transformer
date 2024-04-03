module "lambda_batch_ingestion" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.project
  description   = "Invoked by AWS Step Functions for S3 batch processing"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"
  timeout       = 60
  memory_size   = 128

  trigger_on_package_timestamp = false

  source_path = "${path.module}/code"

  role_name          = "${var.project}-lambda-exec"
  attach_policies    = true
  number_of_policies = 1
  policies           = [aws_iam_policy.lambda_exec.arn]

  environment_variables = {
    "BUCKET_NAME" : var.bucket_name
  }
}