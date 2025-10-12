# Outputs for Lambda function
output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.java_lambda.function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.java_lambda.arn
}

output "invoke_lambda_command" {
  description = "Command to invoke the Lambda function"
  value       = "aws lambda invoke --function-name ${aws_lambda_function.java_lambda.function_name} --endpoint-url ${var.aws_endpoint} --profile ${var.aws_profile} response.json && cat response.json"
}
