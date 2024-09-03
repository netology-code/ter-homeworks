output "instance_name" { 
  value = yandex_compute_instance.name
}

output "fqdn" {
  value = yandex_compute_instance.hostname
}

output "external_ip" {
  value = yandex_compute_instance.network_interface.0.nat_ip_address
}
