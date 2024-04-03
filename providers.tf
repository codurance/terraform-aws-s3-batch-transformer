provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      terraform = "true"
      project   = "s3-object-ingestion"
    }
  }
}
