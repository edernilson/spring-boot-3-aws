terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Environment-specific configuration
locals {
  is_prod = terraform.workspace == "prod"
  
  # Environment-specific settings
  aws_endpoint = local.is_prod ? null : var.aws_endpoint
  aws_profile  = local.is_prod ? var.prod_aws_profile : var.dev_aws_profile
  
  # LocalStack-specific settings (only for dev)
  skip_credentials_validation = !local.is_prod
  skip_metadata_api_check     = !local.is_prod
  skip_requesting_account_id  = !local.is_prod
}

# Configure AWS provider with workspace-aware settings
provider "aws" {
  region  = var.aws_region
  profile = local.aws_profile
  
  # LocalStack endpoints (only for dev workspace)
  dynamic "endpoints" {
    for_each = local.is_prod ? [] : [1]
    content {
      apigateway     = local.aws_endpoint
      cloudformation = local.aws_endpoint
      cloudwatch     = local.aws_endpoint
      dynamodb       = local.aws_endpoint
      ec2            = local.aws_endpoint
      es             = local.aws_endpoint
      firehose       = local.aws_endpoint
      iam            = local.aws_endpoint
      kinesis        = local.aws_endpoint
      lambda         = local.aws_endpoint
      route53        = local.aws_endpoint
      redshift       = local.aws_endpoint
      s3             = local.aws_endpoint
      secretsmanager = local.aws_endpoint
      ses            = local.aws_endpoint
      sns            = local.aws_endpoint
      sqs            = local.aws_endpoint
      ssm            = local.aws_endpoint
      stepfunctions  = local.aws_endpoint
      sts            = local.aws_endpoint
    }
  }
  
  # LocalStack skip settings (only for dev)
  skip_credentials_validation = local.skip_credentials_validation
  skip_metadata_api_check     = local.skip_metadata_api_check
  skip_requesting_account_id  = local.skip_requesting_account_id
}

# IAM role for Lambda execution
resource "aws_iam_role" "lambda_basic_exec" {
  name = "${var.lambda_function_name}-${terraform.workspace}-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Environment = terraform.workspace
    Project     = "aws-lambda-java-demo"
    Group       = "aws-code"
  }
}

# IAM policy attachment for basic Lambda execution
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_basic_exec.name
}

# Lambda function with workspace-specific naming
resource "aws_lambda_function" "java_lambda" {
  function_name    = "${var.lambda_function_name}-${terraform.workspace}"
  filename         = var.lambda_function_jar_path
  handler          = var.lambda_function_handler
  runtime          = var.lambda_function_java_runtime
  role            = aws_iam_role.lambda_basic_exec.arn
  source_code_hash = filebase64sha256(var.lambda_function_jar_path)
  memory_size     = var.lambda_function_memory_size
  timeout         = var.lambda_function_timeout

  tags = {
    Environment = terraform.workspace
    Project     = "aws-lambda-java-demo"
    Group       = "aws-code"
  }
}