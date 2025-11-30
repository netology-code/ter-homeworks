output "vm_id" {
  description = "ID of the created virtual machine"
  value       = yandex_compute_instance.main.id
}

output "vm_name" {
  description = "Name of the virtual machine"
  value       = yandex_compute_instance.main.name
}

output "external_ip" {
  description = "External IP address of the VM"
  value       = yandex_vpc_address.vm_ip.external_ipv4_address[0].address
}

output "internal_ip" {
  description = "Internal IP address of the VM"
  value       = yandex_compute_instance.main.network_interface[0].ip_address
}

output "zone" {
  description = "Zone where VM is running"
  value       = yandex_compute_instance.main.zone
}

output "service_account_name" {
  description = "Name of the service account"
  value       = yandex_iam_service_account.vm_sa.name
}

output "connection_instructions" {
  description = "Instructions for connecting to the VM"
  value       = <<EOT
VM Created Successfully!

Connection Details:
- VM Name: ${yandex_compute_instance.main.name}
- External IP: ${yandex_vpc_address.vm_ip.external_ipv4_address[0].address}
- Internal IP: ${yandex_compute_instance.main.network_interface[0].ip_address}
- Zone: ${yandex_compute_instance.main.zone}

To connect via SSH:
ssh ubuntu@${yandex_vpc_address.vm_ip.external_ipv4_address[0].address}

VM uses VPC resources from remote state:
- Network ID: ${data.terraform_remote_state.vpc.outputs.network_id}
- Subnet ID: ${data.terraform_remote_state.vpc.outputs.subnet_id}
- Security Group ID: ${data.terraform_remote_state.vpc.outputs.security_group_id}

State stored in S3: vm/terraform.tfstate
EOT
}
