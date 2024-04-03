# Overview

This Terraform module facilitates the deployment of a scalable and efficient data flow architecture. It is designed to read data from Amazon S3, transform the data as required, and deliver it to any data visualization platform or storage location of choice. By leveraging Terraform, users can easily provision and manage the necessary infrastructure components to establish a scalable data pipeline.

**Although this module is fully functional and ready to use, it's important to note that this is a demo version intended for demonstration purposes only. In order to fully meet your needs, further development and customization is required!**

## Architecture Choices

The architecture of this data flow module relies on several key components:

- Amazon S3: Serves as the primary data source, providing a scalable and durable storage solution for ingesting raw data. This bucket is not managed by this module, it should be referenced as an input parameter.

- AWS Step Functions: Utilized for orchestrating the data processing workflow. Step Functions provide a reliable and scalable way to coordinate the execution of individual tasks, allowing for complex data transformation workflows.

- AWS Lambda: Each individual object within the S3 bucket triggers a Lambda function to handle reading, transformation, and delivery. 

By leveraging AWS Step Functions in conjunction with Lambda functions, the architecture ensures scalability, fault tolerance, and cost-effectiveness, enabling seamless data processing at scale.


# Usage

**Example - Complete**
```
module "demo_s3_batch" {

  source  = "codurance/s3-batch-transformer/aws"
  version = "1.0.4"

  # Mandatory
  bucket_name = "MY_BUCKET_NAME"

  # Optional 
  project                       = "team_demo"
  bucket_prefix                 = ""
  lambda_invoke_max_concurrency = 50
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.0)

- <a name="requirement_aws"></a> [aws](#requirement\_aws) (>= 5.30)

## Providers

The following providers are used by this module:

- <a name="provider_aws"></a> [aws](#provider\_aws) (>= 5.30)

## Modules

The following Modules are called:

### <a name="module_lambda_batch_ingestion"></a> [lambda\_batch\_ingestion](#module\_lambda\_batch\_ingestion)

Source: terraform-aws-modules/lambda/aws

Version:

## Resources

The following resources are used by this module:

- [aws_iam_policy.lambda_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) (resource)
- [aws_iam_policy.snf_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) (resource)
- [aws_iam_role.sfn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) (resource)
- [aws_iam_role_policy_attachment.policy_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) (resource)
- [aws_sfn_state_machine.sfn_state_machine_prefix_false](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sfn_state_machine) (resource)
- [aws_sfn_state_machine.sfn_state_machine_prefix_true](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sfn_state_machine) (resource)

## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name)

Description: The target bucket name

Type: `string`

Default: `""`

### <a name="input_bucket_prefix"></a> [bucket\_prefix](#input\_bucket\_prefix)

Description: Set the bucket prefix for the target objects. In some cases objects are grouped by year, month, day, hour, etc .

Type: `string`

Default: `""`

### <a name="input_lambda_invoke_max_concurrency"></a> [lambda\_invoke\_max\_concurrency](#input\_lambda\_invoke\_max\_concurrency)

Description: Number of concurrent invocations made by step functions. The bigger the concurrency is the more stress the Opensearch will be expose to. The default value was assigned based on load tests, we strongly recommend to keep this value.

Type: `number`

Default: `5`

### <a name="input_project"></a> [project](#input\_project)

Description: Project name, this label is used to name resources

Type: `string`

Default: `"s3-batch-transform"`

## Outputs

No outputs.
<!-- END_TF_DOCS -->