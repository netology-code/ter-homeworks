# Task 7* - HashiCorp Vault with Terraform

## Task Completion Status: ✅ COMPLETED

This task demonstrates successful integration between Terraform and HashiCorp Vault.

## Verification Results

All requirements have been successfully met:

### ✅ Secret Creation and Reading
- **Original Secret**: `secret/example` with key `test` and value `congrats!`
- **Terraform-Created Secret**: `secret/terraform-generated` with multiple key-value pairs
- **Both secrets** are accessible via Terraform data sources and Vault CLI

### ✅ Terraform Configuration
- Vault provider configured with address `http://localhost:8200`
- Token authentication using `education`
- Successful reading of existing secrets using `vault_generic_secret` data source
- Successful creation of new secrets using `vault_generic_secret` resource
- Proper use of `nonsensitive()` function for output display

### ✅ Vault Setup
- Vault server running in Docker container
- KV v1 secret engine (confirmed by secret paths)
- Accessible via Web UI at http://localhost:8200
- CLI commands working correctly

## Files Created
- `main.tf` - Terraform configuration for Vault integration
- `docker-compose.yml` - Vault deployment configuration
- `verify_completion.sh` - Verification script
- `README.md` - This documentation

## How to Reproduce
1. Start Vault: `docker-compose up -d`
2. Create initial secret via CLI (see commands below)
3. Run Terraform: `terraform init && terraform apply`
4. Verify: `./verify_completion.sh`

## Vault CLI Commands Used
```bash
export VAULT_ADDR='http://127.0.0.1:8200'
docker exec -e VAULT_ADDR vault vault login education
docker exec -e VAULT_ADDR vault vault kv put secret/example test=congrats!
Terraform Outputs
The following outputs are successfully displayed:

vault_example - Complete secret data from secret/example

vault_example_test_key - Specific value of test key

terraform_created_secret - Data from Terraform-created secret

secret_creation_message - Confirmation message

Task 7* has been completed successfully! 🎉
