output "test" {

  value = [
    { vm-web = ["instance name ${yandex_compute_instance.platform.name}", "external ip ${yandex_compute_instance.platform.network_interface[0].nat_ip_address}", "fqdn ${yandex_compute_instance.platform.fqdn}"] },
    { vm-db = ["instance name ${yandex_compute_instance.platform2.name}", "external ip ${yandex_compute_instance.platform2.network_interface[0].nat_ip_address}", "fqdn ${yandex_compute_instance.platform2.fqdn}"] }
  ]
}