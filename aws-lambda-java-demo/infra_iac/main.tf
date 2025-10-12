terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS provider to use LocalStack
provider "aws" {
    region  = var.aws_region
    profile = var.aws_profile
    
    endpoints {
        apigateway     = var.aws_endpoint
        cloudformation = var.aws_endpoint
        cloudwatch     = var.aws_endpoint
        dynamodb       = var.aws_endpoint
        ec2            = var.aws_endpoint
        es             = var.aws_endpoint
        firehose       = var.aws_endpoint
        iam            = var.aws_endpoint
        kinesis        = var.aws_endpoint
        lambda         = var.aws_endpoint
        route53        = var.aws_endpoint
        redshift       = var.aws_endpoint
        s3             = var.aws_endpoint
        secretsmanager = var.aws_endpoint
        ses            = var.aws_endpoint
        sns            = var.aws_endpoint
        sqs            = var.aws_endpoint
        ssm            = var.aws_endpoint
        stepfunctions  = var.aws_endpoint
        sts            = var.aws_endpoint
    }
    
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
}

# IAM role for Lambda execution
resource "aws_iam_role" "lambda_basic_exec" {
  name = "lambda_basic_exec"

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
}

# IAM policy attachment for basic Lambda execution
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_basic_exec.name
}

# Create AWS Lambda from Java project
resource "aws_lambda_function" "java_lambda" {
    function_name = var.lambda_function_name
    filename      = var.lambda_function_jar_path
    handler       = var.lambda_function_handler
    runtime       = var.lambda_function_java_runtime
    role          = aws_iam_role.lambda_basic_exec.arn
    source_code_hash = filebase64sha256(var.lambda_function_jar_path)
    memory_size   = var.lambda_function_memory_size
    timeout       = 30
}