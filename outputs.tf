output "lambda_function_arn" {
  value       = module.lambda_batch_ingestion.lambda_function_arn
  description = "Lambda function ARN"
}

output "lambda_role_arn" {
  value       = module.lambda_batch_ingestion.lambda_role_arn
  description = "Lambda role ARN"
}