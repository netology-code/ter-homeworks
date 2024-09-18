# Read secret from vault
data "vault_generic_secret" "vault_example"{
 path = "secret/example"
}

# Create secret in vault
resource "vault_generic_secret" "s3_sec" {
  path = "secret/s3_sec"

  data_json = jsonencode(var.s3_dev_mod)
}