# AWS Lambda Java Demo

A demonstration project showcasing AWS Lambda function development with Java and Infrastructure as Code (IaC) using Terraform.

## Project Structure

```
aws-lambda-java-demo/
├── src/
│   ├── main/java/com/edernilson/aws/
│   │   ├── App.java
│   │   └── HelloWorldRequestHandler.java
│   └── test/java/com/edernilson/aws/
│       └── AppTest.java
├── infra_iac/
│   ├── main.tf
│   ├── variable.tf
│   └── outputs.tf
├── pom.xml
└── README.md
```

## Features

- **Java 11 Lambda Function**: Simple request handler that processes string inputs
- **Maven Build System**: Configured with AWS Lambda dependencies and shade plugin
- **Infrastructure as Code**: Terraform configuration for AWS Lambda deployment
- **LocalStack Support**: Local development and testing environment
- **IAM Role Management**: Proper Lambda execution role with policies

## Prerequisites

- Java 11+
- Maven 3.6+
- Terraform 1.0+
- AWS CLI
- LocalStack (for local testing)

## Quick Start

### 1. Build the Project
```bash
mvn clean package
```

### 2. Deploy Infrastructure
```bash
cd infra_iac
terraform init
terraform plan
terraform apply
```

### 3. Invoke Lambda Function
```bash
aws lambda invoke \
  --function-name java-lambda-demo \
  --endpoint-url http://localhost:4566 \
  --profile localstack \
  --region ca-east-1 \
  --payload '"Hello World"' \
  response.json && cat response.json
```

## Lambda Function Details

- **Handler**: `com.edernilson.aws.HelloWorldRequestHandler`
- **Runtime**: Java 11
- **Memory**: 512 MB
- **Timeout**: 30 seconds
- **Input**: String
- **Output**: String with prefix "Meu primeiro request handler: [INPUT]"

## Infrastructure Configuration

The Terraform configuration includes:
- AWS Lambda function
- IAM execution role with basic execution policy
- LocalStack endpoint configuration
- Configurable variables for different environments

## Development

### Local Testing with LocalStack
1. Start LocalStack: `localstack start`
2. Deploy infrastructure: `terraform apply`
3. Invoke function using AWS CLI with LocalStack endpoint

### Building Fat JAR
The Maven shade plugin creates a fat JAR with all dependencies included, suitable for Lambda deployment.

## Configuration Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `aws_region` | `us-east-1` | AWS region for deployment |
| `lambda_function_name` | `java-lambda-demo` | Lambda function name |
| `lambda_function_memory_size` | `512` | Memory allocation in MB |

## Author

**Eder Nilson**  
Email: eder.nilson@gmail.com