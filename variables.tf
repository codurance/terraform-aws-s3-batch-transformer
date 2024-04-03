variable "project" {
  type        = string
  default     = "s3-batch-transform"
  description = "Project name, this label is used to name resources"
}

variable "bucket_name" {
  type        = string
  default     = ""
  description = "The target bucket name"
}

variable "bucket_prefix" {
  type        = string
  default     = ""
  description = "Set the bucket prefix for the target objects. In some cases objects are grouped by year, month, day, hour, etc . "
}

variable "lambda_invoke_max_concurrency" {
  type        = number
  default     = 5
  description = "Number of concurrent invocations made by step functions. The bigger the concurrency is the more stress the Opensearch will be expose to. The default value was assigned based on load tests, we strongly recommend to keep this value."
}
