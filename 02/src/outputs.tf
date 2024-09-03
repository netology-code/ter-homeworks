output "instance_name" { 
  value = yandex_compute_instance.vm_web_yandex_compute_instance_name.name
}

output "fqdn" {
  value = yandex_compute_instance.platform-web.fqdn
}

output "external_ip" {
  value = yandex_compute_instance.platform-web.network_interface.0.nat_ip_address
}
