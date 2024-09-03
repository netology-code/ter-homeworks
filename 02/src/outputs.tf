output "instance_name" { 
  value = yandex_compute_instance.name.*
}

output "fqdn" {
  value = yandex_compute_instance.platform-web.hostname
}

output "external_ip" {
  value = yandex_compute_instance.platform-web.network_interface.0.nat_ip_address
}
