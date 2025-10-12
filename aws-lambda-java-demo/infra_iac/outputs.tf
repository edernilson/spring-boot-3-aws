# Outputs for Lambda function
output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.java_lambda.function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.java_lambda.arn
}

output "workspace" {
  description = "Current Terraform workspace"
  value       = terraform.workspace
}

output "invoke_lambda_command" {
  description = "Command to invoke the Lambda function"
  value = terraform.workspace == "prod" ? "aws lambda invoke --function-name ${aws_lambda_function.java_lambda.function_name} --profile ${var.prod_aws_profile} response.json && cat response.json" : "aws lambda invoke --function-name ${aws_lambda_function.java_lambda.function_name} --endpoint-url ${var.aws_endpoint} --profile ${var.dev_aws_profile} --region ${var.aws_region} response.json && cat response.json"
}
