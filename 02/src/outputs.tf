output "test" {

  value = [
    { vm_web = [yandex_compute_instance.platform.name,yandex_compute_instance.platform.network_interface[0].nat_ip_address, yandex_compute_instance.platform.fqdn ] },
    { vm_db = [yandex_compute_instance.platform-b.name,yandex_compute_instance.platform-b.network_interface[0].nat_ip_address, yandex_compute_instance.platform-b.fqdn  ] }
  ]
}