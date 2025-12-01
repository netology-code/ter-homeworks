#!/bin/bash

echo "=== Destroying Remote State Modules ==="

# Шаг 1: Удаление VM модуля (сначала, т.к. зависит от VPC)
echo "1. Destroying VM module..."
cd vm_module
terraform destroy -auto-approve

# Шаг 2: Удаление VPC модуля
echo "2. Destroying VPC module..."
cd ../vpc_module
terraform destroy -auto-approve

echo "=== Cleanup Complete ==="
