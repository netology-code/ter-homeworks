output "test" {

  value = [
    { WEB = ["external_ip ${yandex_compute_instance.platform.network_interface[0].nat_ip_address}", "instance_name ${yandex_compute_instance.platform.name}", ""] },
    { DB = ["external_ip ${yandex_compute_instance.platform-db.network_interface[0].nat_ip_address}"] },

  ]
}