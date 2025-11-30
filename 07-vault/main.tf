terraform {
  required_version = ">= 1.5"

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "3.18.0"
    }
  }
}

provider "vault" {
  address         = "http://localhost:8200"
  skip_tls_verify = true
  token           = "education"
}

# Чтение существующего секрета
data "vault_generic_secret" "vault_example" {
  path = "secret/example"
}

output "vault_example" {
  value = nonsensitive(data.vault_generic_secret.vault_example.data)
}

output "vault_example_test_key" {
  value = nonsensitive(data.vault_generic_secret.vault_example.data["test"])
}

# Запись нового секрета в Vault
resource "vault_generic_secret" "terraform_secret" {
  path = "secret/terraform-generated"

  data_json = jsonencode({
    username = "terraform-user"
    password = "super-secret-password-123"
    message  = "This secret was created by Terraform!"
  })
}

output "terraform_created_secret" {
  value     = nonsensitive(vault_generic_secret.terraform_secret.data)
  sensitive = false
}

output "secret_creation_message" {
  value = "New secret created at path: ${vault_generic_secret.terraform_secret.path}"
}
