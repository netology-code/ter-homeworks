
output "test" {

  value = [
    { db = [yandex_compute_instance.platform_db.name, "ubuntu@${yandex_compute_instance.platform_db.network_interface[0].nat_ip_address}", format("%s.%s", yandex_compute_instance.platform_db.name, var.domain_name)] },
    { web = [yandex_compute_instance.platform.name, "ubuntu@${yandex_compute_instance.platform.network_interface[0].nat_ip_address}", format("%s.%s", yandex_compute_instance.platform.name, var.domain_name)] }

  ]
}
