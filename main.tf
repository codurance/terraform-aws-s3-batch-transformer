module "ingest-s3-objects" {

  source = "./modules/ingest-s3-objects"

  # Mandatory fields
  bucket_name = "demo-code-vpc-flowlogs-bucket-tst" # The bucket where your objects are

  # Optional
  project = "ingest-s3-objects-module" # Used to name resources, naming convention
  # bucket_prefix                 = "2024/03/01/"              # Use prefix to filter a subset of logs
  # lambda_invoke_max_concurrency = 5 # Process 5 objects at a time. Balance this 

}
