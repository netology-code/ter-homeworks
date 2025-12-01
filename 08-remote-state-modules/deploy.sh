#!/bin/bash

echo "=== Remote State Modules Deployment ==="

# Шаг 1: Развертывание VPC модуля
echo "1. Deploying VPC module..."
cd vpc_module

terraform init
if [ $? -ne 0 ]; then
    echo "Error: VPC module initialization failed"
    exit 1
fi

terraform apply -auto-approve
if [ $? -ne 0 ]; then
    echo "Error: VPC module deployment failed"
    exit 1
fi

echo "VPC module deployed successfully!"
terraform output

# Шаг 2: Развертывание VM модуля
echo "2. Deploying VM module..."
cd ../vm_module

terraform init
if [ $? -ne 0 ]; then
    echo "Error: VM module initialization failed"
    exit 1
fi

terraform apply -auto-approve
if [ $? -ne 0 ]; then
    echo "Error: VM module deployment failed"
    exit 1
fi

echo "VM module deployed successfully!"
terraform output

echo "=== Deployment Complete ==="
echo "Both modules deployed using remote state in S3!"
