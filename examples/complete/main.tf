module "demo_s3_batch" {
  source  = "codurance/terraform-aws-s3-batch-transformer/aws"
  version = "1.0.0"


  buckey_name = "MY_BUCKET_NAME"
}
