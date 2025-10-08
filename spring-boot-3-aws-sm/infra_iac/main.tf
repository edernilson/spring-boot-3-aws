terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "random_id" "secret_suffix" {
  byte_length = 4
}

resource "aws_secretsmanager_secret" "test_secret" {
  name = "repost/test/secret-${random_id.secret_suffix.hex}"
  
  tags = {
    Name = "testsm"
  }
}

resource "aws_secretsmanager_secret_version" "test_secret_version" {
  secret_id = aws_secretsmanager_secret.test_secret.id
  secret_string = jsonencode({
    "${var.secret_key}" = var.secret_value
  })
}
