output "instance_name" { 
  value = yandex_compute_instance.vm.*.name
}

output "fqdn" {
  value = yandex_compute_instance.vm.*.hostname
}

output "external_ip" {
  value = yandex_compute_instance.vm.*.network_interface.0.nat_ip_address
}
