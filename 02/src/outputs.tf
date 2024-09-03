output "develop" { 
  value = [
    { external_name_web = yandex_compute_instance.platform-web.name, yandex_compute_instance.platform-db.name },
    { external_name_db  = yandex_compute_instance.platform-db.name }
  ]
}

/*
output "platform_web_fqdn" {
  value = yandex_compute_instance.platform-web.fqdn
}

output "platform_web_external_ip" {
  value = yandex_compute_instance.platform-web.network_interface.0.nat_ip_address
}

output "platform_db_instance_name" { 
  value = yandex_compute_instance.platform-db.name
}

output "platform_db_fqdn" {
  value = yandex_compute_instance.platform-db.fqdn
}

output "platform_db_external_ip" {
  value = yandex_compute_instance.platform-db.network_interface.0.nat_ip_address
*/
