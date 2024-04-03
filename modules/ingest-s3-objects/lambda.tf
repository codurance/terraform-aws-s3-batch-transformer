module "lambda_batch_ingestion" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.project
  description   = "This function is invoked by AWS Step Functions, one execution per S3 object to ingest in Opensearch."
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.10"
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

  tags = {
    Name = var.project
  }
}