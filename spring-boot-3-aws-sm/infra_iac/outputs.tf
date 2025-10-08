output "secret_arn" {
  description = "ARN of the created secret"
  value       = aws_secretsmanager_secret.test_secret.arn
}

output "secret_name" {
  description = "Name of the created secret"
  value       = aws_secretsmanager_secret.test_secret.name
}
