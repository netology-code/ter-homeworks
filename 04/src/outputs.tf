output "marketing_vm_ssh" {
  value = "ssh ubuntu@${module.marketing-vm.external_ip_address[0]}"
}

output "analytics_vm_ssh" {
  value = "ssh ubuntu@${module.analytics-vm.external_ip_address[0]}"
}

output "vault_example" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
} 