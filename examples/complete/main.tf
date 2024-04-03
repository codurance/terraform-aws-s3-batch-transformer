module "demo_s3_batch" {

  source  = "codurance/terraform-aws-s3-batch-transformer/aws"
  version = "1.0.2"

  # Mandatory
  buckey_name = "MY_BUCKET_NAME"

  # Optional 
  project                       = "team_demo"
  bucket_prefix                 = ""
  lambda_invoke_max_concurrency = 50
}

