#output "netology_develop_platform_web_instance_name" { 
#  value = yandex_compute_instance.vm_web_yandex_compute_instance_name.name
#}

#output "netology_develop_platform_web_fqdn" {
#  value = yandex_compute_instance.vm_web_yandex_compute_instance_name.fqdn
#}

#output "netology_develop_platform_web_external_ip" {
#  value = yandex_compute_instance.vm_web_yandex_compute_instance_name.network_interface.0.nat_ip_address
#}

output "netology_develop_platform_db_instance_name" { 
  value = yandex_compute_instance.vm_db_yandex_compute_instance_name.name
}

output "netology_develop_platform_db_fqdn" {
  value = yandex_compute_instance.vm_db_yandex_compute_instance_name.fqdn
}

output "netology_develop_platform_db_external_ip" {
  value = yandex_compute_instance.vm_db_yandex_compute_instance_name.network_interface.0.nat_ip_address
}