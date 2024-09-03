output "instance_name" { 
  value = yandex_compute_instance.vm_*_yandex_compute_instance_name.name
}

output "fqdn" {
  value = yandex_compute_instance.vm_*_yandex_compute_instance_name.fqdn
}

output "external_ip" {
  value = yandex_compute_instance.vm_*_yandex_compute_instance_name.network_interface.0.nat_ip_address
}
