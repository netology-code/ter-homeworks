# Task 8* - Remote State Modules (VPC + VM)

This task demonstrates splitting a root module into two separate modules using remote state in S3.

## Architecture

- **VPC Module**: Creates network infrastructure (VPC, subnet, security group)
- **VM Module**: Creates virtual machine that uses VPC resources via remote state
- **Remote State**: Both modules store their state in S3 bucket from task 6*

## Prerequisites

1. S3 bucket from task 6* must be available
2. Valid Yandex Cloud credentials
3. SSH key pair for VM access

## Setup

1. Update credentials in modules:
   ```bash
   ./setup_credentials.sh
Deploy modules sequentially:

bash
./deploy.sh
Manual Deployment
Step 1: Deploy VPC Module
bash
cd vpc_module
terraform init
terraform apply
Step 2: Deploy VM Module
bash
cd ../vm_module
terraform init  
terraform apply
Module Dependencies
VM module depends on VPC module outputs:

subnet_id - for network interface

security_group_id - for security rules

zone - for resource placement

Remote State Configuration
Both modules use S3 backend:

hcl
backend "s3" {
  endpoint   = "storage.yandexcloud.net"
  bucket     = "your-bucket-name"
  key        = "module/terraform.tfstate"
  access_key = "your-access-key"
  secret_key = "your-secret-key"
}
Data Source for Remote State
VM module reads VPC state:

hcl
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "your-bucket-name"
    key        = "vpc/terraform.tfstate"
    access_key = "your-access-key"
    secret_key = "your-secret-key"
  }
}
Verification
Check both state files in S3 bucket

Verify VM can be accessed via SSH

Confirm network connectivity

Cleanup
bash
./destroy.sh
Benefits of This Approach
Separation of Concerns: Network and compute in separate modules

State Isolation: Each module has its own state file

Reusability: VPC module can be used by multiple VM modules

Team Collaboration: Different teams can work on different modules

Safe Modifications: Changes to one module don't affect the other
