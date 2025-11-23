output "internal_ip" {
  value = yandex_compute_instance.marketing_vm.network_interface.0.ip_address
}

output "external_ip" {
  value = yandex_compute_instance.marketing_vm.network_interface.0.nat_ip_address
}

output "name" {
  value = yandex_compute_instance.marketing_vm.name
}
