output "vm" {

  value = [for k in concat(yandex_compute_instance.vms-web, values(yandex_compute_instance.vms-db), yandex_compute_instance.vms-web-with-volume[*]): {
    name = k.name,
    id = k.id,
    fqdn = k.fqdn
  }]
}
