module "demo_s3_batch" {

  source  = "codurance/s3-batch-transformer/aws"
  version = "1.0.2"

  # Mandatory
  bucket_name = "MY_BUCKET_NAME"

  # Optional 
  project                       = "team_demo"
  bucket_prefix                 = ""
  lambda_invoke_max_concurrency = 50
}

