output "test" {

  value = [
    { WEB = ["external_ip${yandex_compute_instance.platform.network_interface[0].nat_ip_address}"] },
    { DB = ["external_ip${yandex_compute_instance.platform-db.network_interface[0].nat_ip_address}"] },

  ]
}