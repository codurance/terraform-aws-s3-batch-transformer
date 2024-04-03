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

**Example**
```
module "ingest-s3-objects" {

  source = "./modules/ingest-s3-objects"

  # Mandatory fields
  bucket_name = "demo-code-vpc-flowlogs-bucket-tst" # The bucket where your objects are

  # Optional
  project = "ingest-s3-objects-module" # Used to name resources, naming convention
  # bucket_prefix                 = "2024/03/01/"              # Use prefix to filter a subset of logs
  # lambda_invoke_max_concurrency = 5 # Process 5 objects at a time. Balance this 

}

```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.42.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda_batch_ingestion"></a> [lambda\_batch\_ingestion](#module\_lambda\_batch\_ingestion) | terraform-aws-modules/lambda/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.lambda_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.snf_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.sfn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.policy_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_sfn_state_machine.sfn_state_machine](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sfn_state_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The target bucket name, where you have your targetr objetcs | `string` | n/a | yes |
| <a name="input_lambda_invoke_max_concurrency"></a> [lambda\_invoke\_max\_concurrency](#input\_lambda\_invoke\_max\_concurrency) | Number of concurrent invocations made by step functions. The bigger the concurrency is the more stress the Opensearch will be expose to. The default value was assigned based on load tests, we strongly recommend to keep this value. | `number` | `5` | no |
| <a name="input_project"></a> [project](#input\_project) | Set the project name. This variable is used to name resources. | `string` | `"ingest-s3-objects"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->