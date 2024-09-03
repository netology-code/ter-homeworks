output "netology-develop-platform-web instance_name" { 
  value = yandex_compute_instance.vm_web_yandex_compute_instance_name.name
}

output "netology-develop-platform-web fqdn" {
  value = yandex_compute_instance.vm_web_yandex_compute_instance_name.fqdn
}

output "netology-develop-platform-web external_ip" {
  value = yandex_compute_instance.vm_web_yandex_compute_instance_name.network_interface.0.nat_ip_address
}

output "netology-develop-platform-db instance_name" { 
  value = yandex_compute_instance.vm_db_yandex_compute_instance_name.name
}

output "netology-develop-platform-db fqdn" {
  value = yandex_compute_instance.vm_db_yandex_compute_instance_name.fqdn
}

output "netology-develop-platform-db external_ip" {
  value = yandex_compute_instance.vm_db_yandex_compute_instance_name.network_interface.0.nat_ip_address
}