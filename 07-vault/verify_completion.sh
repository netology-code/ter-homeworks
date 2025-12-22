#!/bin/bash
echo "=== Task 7* Final Verification ==="

echo "1. Checking Vault container..."
docker ps | grep vault

echo "2. Checking Vault status..."
docker exec -e VAULT_ADDR='http://127.0.0.1:8200' vault vault status

echo "3. Listing all secrets..."
docker exec -e VAULT_ADDR='http://127.0.0.1:8200' vault vault kv list secret/

echo "4. Checking original secret..."
docker exec -e VAULT_ADDR='http://127.0.0.1:8200' vault vault kv get secret/example

echo "5. Checking Terraform-created secret..."
docker exec -e VAULT_ADDR='http://127.0.0.1:8200' vault vault kv get secret/terraform-generated

echo "6. Checking Terraform outputs..."
terraform output

echo "=== Verification Complete ==="
