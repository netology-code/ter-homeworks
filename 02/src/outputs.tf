
output "test" {

  value = [
    { db = [yandex_compute_instance.platform_db.name, "ubuntu@${yandex_compute_instance.platform_db.network_interface[0].nat_ip_address}", yandex_compute_instance.platform_db.fqdn] },
    { web = [yandex_compute_instance.platform.name, "ubuntu@${yandex_compute_instance.platform.network_interface[0].nat_ip_address}", yandex_compute_instance.platform.fqdn] }

  ]
}
