# Terraform AWS Platform
## Overview
This project provisions AWS infrastructure using Terraform and implements CI/CD automation using GitHub Actions.

The infrastructure includes:
- VPC
- Public and Private Subnets
- Bastion EC2 Instance
- PostgreSQL RDS Instance
- Security Groups
- Remote Terraform State Backend (S3 + DynamoDB)

Separate staging and production environments are supported through environment-specific Terraform configurations.

## Project Structure
```text
.
├── bootstrap/
│   └── Creates S3 backend and DynamoDB lock tables
│
├── modules/
│   ├── vpc/
│   ├── ec2/
│   ├── rds/
│   └── security-group/
│
├── environments/
│   ├── staging/
│   └── production/
│
├── .github/
│   └── workflows/
│
└── README.md
```

## Prerequisites
Before running the project, ensure the following tools and resources are available.

### Software
- Terraform >= 1.0
- AWS CLI
- Git

### AWS Requirements

An AWS account with permissions to create:
- VPCs
- Subnets
- Route Tables
- Internet Gateways
- Security Groups
- EC2 Instances
- RDS Instances
- S3 Buckets
- DynamoDB Tables
- Secrets Manager Resources

### AWS Credentials
Configure AWS credentials locally:
```bash
aws configure
```
Provide:
```text
AWS Access Key ID
AWS Secret Access Key
AWS Region (ap-south-1)
```
### SSH Key Pair
An existing EC2 Key Pair is required for Bastion Host access.
Update the following variable with a key pair available in your AWS account:
```hcl
key_pair_name = "<your-key-pair>"
```

### GitHub Secrets

The following repository secrets must be configured for GitHub Actions:
```text
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
```

## Manual Execution
### Bootstrap Backend

Create the Terraform backend resources:
```bash
cd bootstrap
terraform init
terraform plan
terraform apply
```
This creates:
- S3 backend buckets
- DynamoDB lock tables

### Staging Environment
```bash
cd environments/staging
terraform init
terraform plan
terraform apply
```

### Production Environment
```bash
cd environments/production
terraform init
terraform plan
terraform apply
```

### Destroy Infrastructure
If cleanup is required:
```bash
terraform destroy
```
Run the command from the desired environment directory.

## CI/CD Workflow
### Pull Request Validation
Triggered on pull requests targeting `main`.
Checks performed:
- Terraform Format Validation (`terraform fmt -check -recursive`)
- Terraform Validation (`terraform validate`)
- Terraform Plan (`terraform plan`)
### Staging Deployment
Triggered on pushes to `main`.
- Protected by GitHub Environment approval
- Terraform Init
- Terraform Validate
- Terraform Plan
- Terraform Apply
### Production Deployment
Example:
```bash
git tag v1.0.0
git push origin v1.0.0
```
Any tag matching the pattern below will trigger the production deployment:

```text
v*.*.*
```
Examples:
```text
v1.0.0
v1.0.1
v1.1.0
v2.0.0
```
- Protected by GitHub Environment approval
- Terraform Init
- Terraform Validate
- Terraform Plan
- Terraform Apply

## Deployment Flow

```text
Feature Branch
        ↓
Pull Request
        ↓
PR Validation
        ↓
Merge to Main
        ↓
Staging Environment Approval
        ↓
Staging Deployment
        ↓
Release Tag (v*.*.*)
        ↓
Production Environment Approval
        ↓
Production Deployment
```