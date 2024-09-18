output "vault_example" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
} 