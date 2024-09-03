output "instance_name" { 
  value = yandex_compute_instance.platform-web.name
}

#output "netology_develop_platform_web_fqdn" {
#  value = yandex_compute_instance.vm_web_yandex_compute_instance_name.fqdn
#}

#output "netology_develop_platform_web_external_ip" {
#  value = yandex_compute_instance.vm_web_yandex_compute_instance_name.network_interface.0.nat_ip_address
#}

output "instance_name" { 
  value = yandex_compute_instance.platform-db.name
}

output "fqdn" {
  value = yandex_compute_instance.platform-db.fqdn
}

output "external_ip" {
  value = yandex_compute_instance.platform-db.network_interface.0.nat_ip_address
}