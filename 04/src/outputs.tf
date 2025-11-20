output "marketing_vm_info" {
  description = "Information about marketing VM"
  value = {
    name        = module.marketing_vm.vm_name
    external_ip = module.marketing_vm.external_ip
    internal_ip = module.marketing_vm.internal_ip
    labels      = module.marketing_vm.labels
  }
}

output "analytics_vm_info" {
  description = "Information about analytics VM"
  value = {
    name        = module.analytics_vm.vm_name
    external_ip = module.analytics_vm.external_ip
    internal_ip = module.analytics_vm.internal_ip
    labels      = module.analytics_vm.labels
  }
}

output "vpc_network_info" {
  description = "Information about VPC network"
  value = {
    network_id = yandex_vpc_network.develop.id
    subnet_id  = yandex_vpc_subnet.develop.id
    cidr_blocks = yandex_vpc_subnet.develop.v4_cidr_blocks
  }
}

output "ssh_connection_commands" {
  description = "SSH connection commands for VMs"
  value = {
    marketing = "ssh ubuntu@${module.marketing_vm.external_ip}"
    analytics = "ssh ubuntu@${module.analytics_vm.external_ip}"
  }
}
