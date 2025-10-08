variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "secret_key" {
  description = "The key for the secret"
  type        = string
  default     = "password"
}

variable "secret_value" {
  description = "The value for the secret"
  type        = string
  default     = "test"
  sensitive   = true
}
