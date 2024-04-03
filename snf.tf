resource "aws_sfn_state_machine" "sfn_state_machine_prefix_false" {

  count = var.bucket_prefix == "" ? 1 : 0

  name     = var.project
  role_arn = aws_iam_role.sfn.arn

  definition = <<EOF
{
  "Comment": "A description of my state machine",
  "StartAt": "S3 object keys",
  "States": {
    "S3 object keys": {
      "Type": "Map",
      "ItemProcessor": {
        "ProcessorConfig": {
          "Mode": "DISTRIBUTED",
          "ExecutionType": "STANDARD"
        },
        "StartAt": "Lambda Invoke",
        "States": {
          "Lambda Invoke": {
            "Type": "Task",
            "Resource": "arn:aws:states:::lambda:invoke",
            "OutputPath": "$.Payload",
            "Parameters": {
              "Payload.$": "$",
              "FunctionName": "${module.lambda_batch_ingestion.lambda_function_arn}:$LATEST"
            },
            "Retry": [
              {
                "ErrorEquals": [
                  "Lambda.ServiceException",
                  "Lambda.AWSLambdaException",
                  "Lambda.SdkClientException",
                  "Lambda.TooManyRequestsException"
                ],
                "IntervalSeconds": 2,
                "MaxAttempts": 6,
                "BackoffRate": 2
              }
            ],
            "End": true
          }
        }
      },
      "ItemReader": {
        "Resource": "arn:aws:states:::s3:listObjectsV2",
        "Parameters": {
          "Bucket": "${var.bucket_name}"
        },
        "ReaderConfig": {}
      },
      "MaxConcurrency": ${var.lambda_invoke_max_concurrency},
      "Label": "S3objectkeys",
      "End": true,
      "ResultPath": null
    }
  }
}
EOF
}

resource "aws_sfn_state_machine" "sfn_state_machine_prefix_true" {

  count = length(var.bucket_prefix) > 0 ? 1 : 0

  name     = var.project
  role_arn = aws_iam_role.sfn.arn

  definition = <<EOF
{
  "Comment": "A description of my state machine",
  "StartAt": "S3 object keys",
  "States": {
    "S3 object keys": {
      "Type": "Map",
      "ItemProcessor": {
        "ProcessorConfig": {
          "Mode": "DISTRIBUTED",
          "ExecutionType": "STANDARD"
        },
        "StartAt": "Lambda Invoke",
        "States": {
          "Lambda Invoke": {
            "Type": "Task",
            "Resource": "arn:aws:states:::lambda:invoke",
            "OutputPath": "$.Payload",
            "Parameters": {
              "Payload.$": "$",
              "FunctionName": "${module.lambda_batch_ingestion.lambda_function_arn}:$LATEST"
            },
            "Retry": [
              {
                "ErrorEquals": [
                  "Lambda.ServiceException",
                  "Lambda.AWSLambdaException",
                  "Lambda.SdkClientException",
                  "Lambda.TooManyRequestsException"
                ],
                "IntervalSeconds": 2,
                "MaxAttempts": 6,
                "BackoffRate": 2
              }
            ],
            "End": true
          }
        }
      },
      "ItemReader": {
        "Resource": "arn:aws:states:::s3:listObjectsV2",
        "Parameters": {
          "Bucket": "${var.bucket_name}",
          "Prefix": "${var.bucket_prefix}"
        },
        "ReaderConfig": {}
      },
      "MaxConcurrency": ${var.lambda_invoke_max_concurrency},
      "Label": "S3objectkeys",
      "End": true,
      "ResultPath": null
    }
  }
}
EOF
}