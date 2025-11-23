output "prod_network" {
  value = module.vpc_prod.network_name
}

output "prod_subnets" {
  value = module.vpc_prod.subnet_ids
}

output "dev_network" {
  value = module.vpc_dev.network_name
}

output "dev_subnets" {
  value = module.vpc_dev.subnet_ids
}

# Outputs для виртуальных машин
output "analytics_vm_ip" {
  value = yandex_compute_instance.analytics_vm.network_interface[0].nat_ip_address
}

output "marketing_vm_ip" {
  value = yandex_compute_instance.marketing_vm.network_interface[0].nat_ip_address
}

output "marketing_vm_internal_ip" {
  value = yandex_compute_instance.marketing_vm.network_interface[0].ip_address
}

output "ssh_connection_commands" {
  value = {
    analytics = "ssh -i ~/.ssh/terraform_rsa ubuntu@${yandex_compute_instance.analytics_vm.network_interface[0].nat_ip_address}"
    marketing = "ssh -i ~/.ssh/terraform_rsa ubuntu@${yandex_compute_instance.marketing_vm.network_interface[0].nat_ip_address}"
  }
}
