output "marketing_vm_info" {
  description = "Information about marketing VM"
  value = {
    name        = yandex_compute_instance.marketing_vm.name
    external_ip = yandex_compute_instance.marketing_vm.network_interface.0.nat_ip_address
    internal_ip = yandex_compute_instance.marketing_vm.network_interface.0.ip_address
    labels      = yandex_compute_instance.marketing_vm.labels
  }
}

output "analytics_vm_info" {
  description = "Information about analytics VM"
  value = {
    name        = yandex_compute_instance.analytics_vm.name
    external_ip = yandex_compute_instance.analytics_vm.network_interface.0.nat_ip_address
    internal_ip = yandex_compute_instance.analytics_vm.network_interface.0.ip_address
    labels      = yandex_compute_instance.analytics_vm.labels
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
    marketing = "ssh ubuntu@${yandex_compute_instance.marketing_vm.network_interface.0.nat_ip_address}"
    analytics = "ssh ubuntu@${yandex_compute_instance.analytics_vm.network_interface.0.nat_ip_address}"
  }
  sensitive = false
}
