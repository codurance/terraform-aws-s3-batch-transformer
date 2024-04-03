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
  description = "Bucket prefix to filter a subset of objects. If objects are grouped by a time-based prefix, this field is helpful to specify the time-window to process."
}

variable "lambda_invoke_max_concurrency" {
  type        = number
  default     = 5
  description = "Number of concurrent invocations made by step functions. The bigger the concurrency is the more stress the Opensearch will be expose to. The default value was assigned based on load tests, we strongly recommend to keep this value."
}
