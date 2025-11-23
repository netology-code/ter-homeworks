# outputs.tf

output "marketing_vm_ip" {
  description = "External IP address of the marketing VM"
  value       = module.marketing_vm.external_ip
}

output "analytics_vm_ip" {
  description = "External IP address of the analytics VM"
  value       = yandex_compute_instance.analytics_vm.network_interface[0].nat_ip_address
}

output "vpc_network_info" {
  description = "Information about VPC network"
  value = {
    network_id    = module.vpc.network_id
    subnet_id     = module.vpc.subnet_id
    network_name  = module.vpc.network_name
    cidr_blocks   = module.vpc.subnet_cidr_blocks
  }
}

output "ssh_connection_commands" {
  description = "SSH connection commands for VMs"
  value = {
    marketing = "ssh -i ~/.ssh/terraform_rsa ubuntu@${module.marketing_vm.external_ip}"
    analytics = "ssh -i ~/.ssh/terraform_rsa ubuntu@${yandex_compute_instance.analytics_vm.network_interface[0].nat_ip_address}"
  }
}
