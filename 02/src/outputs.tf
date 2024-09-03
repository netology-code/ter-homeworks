output "netology_develop_platform_web instance_name" { 
  value = yandex_compute_instance.vm_web_yandex_compute_instance_name.name
}

output "netology_develop_platform_web fqdn" {
  value = yandex_compute_instance.vm_web_yandex_compute_instance_name.fqdn
}

output "netology_develop_platform_web external_ip" {
  value = yandex_compute_instance.vm_web_yandex_compute_instance_name.network_interface.0.nat_ip_address
}

output "netology_develop_platform_db instance_name" { 
  value = yandex_compute_instance.vm_db_yandex_compute_instance_name.name
}

output "netology_develop_platform_db fqdn" {
  value = yandex_compute_instance.vm_db_yandex_compute_instance_name.fqdn
}

output "netology_develop_platform_db external_ip" {
  value = yandex_compute_instance.vm_db_yandex_compute_instance_name.network_interface.0.nat_ip_address
}