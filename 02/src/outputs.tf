#output "instances_info" {
#  value = [
#    {
#      WEB = [
#        "external_ip: ${yandex_compute_instance.platform.network_interface[0].nat_ip_address}",
#        "instance_name: ${yandex_compute_instance.platform.name}",
#        "fqdn: ${yandex_compute_instance.platform.fqdn}"
#      ]
#    },
#    {
#      DB = [
#        "external_ip: ${yandex_compute_instance.platform-db.network_interface[0].nat_ip_address}",
#        "instance_name: ${yandex_compute_instance.platform-db.name}",
#        "fqdn: ${yandex_compute_instance.platform-db.fqdn}"
#      ]
#    }
#  ]
#}
