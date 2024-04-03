## Usage

# Ingest S3 Objects
With this powerful tool, you can effortlessly select and process any number of objects from your Amazon S3 bucket with ease. Whether you're managing vast amounts of data or just a few files, this module streamlines the process, saving you time and effort.

The heart of this module lies in its Lambda function, which comes pre-loaded with basic code tailored to process CSV files. This serves as a convenient starting point, allowing you to quickly test the functionality of the module. Moreover, this code can be easily customized and adapted to suit your specific use case, ensuring seamless integration into your workflow.
## Usage

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