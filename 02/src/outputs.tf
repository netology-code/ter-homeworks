output "vm" {

  value = [
    { web = [
                "name: ${yandex_compute_instance.platform.name}",
                "hostname: ${yandex_compute_instance.platform.fqdn}",
                "external_ip: ${yandex_compute_instance.platform.network_interface[0].nat_ip_address}", 
            ] 
    },
    { db = [
                "name: ${yandex_compute_instance.platform_db.name}",
                "hostname: ${yandex_compute_instance.platform_db.fqdn}",
                "external_ip: ${yandex_compute_instance.platform_db.network_interface[0].nat_ip_address}"
            ] 
    }
  ]
}
