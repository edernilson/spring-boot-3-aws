variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "The AWS profile to use"
  type        = string
  default     = "localstack"
}

variable "aws_endpoint" {
  description = "The AWS endpoint to use (LocalStack endpoint)"
  type        = string
  default     = "http://localhost:4566"
}

variable "lambda_function_name" {
  description = "The name of the AWS Lambda function"
  type        = string
  default     = "java-lambda-demo"
}

variable "lambda_function_handler" {
  description = "The handler for the AWS Lambda function"
  type        = string
  default     = "com.edernilson.aws.HelloWorldRequestHandler"
}

variable "lambda_function_java_runtime" {
  description = "The runtime for the AWS Lambda function"
  type        = string
  default     = "java11"
}

variable "lambda_function_memory_size" {
  description = "The memory size for the AWS Lambda function"
  type        = number
  default     = 512
}

variable "lambda_function_jar_path" {
  description = "The path to the AWS Lambda function jar file"
  type        = string
  default     = "../target/aws-lambda-java-demo-1.0-SNAPSHOT.jar"
}