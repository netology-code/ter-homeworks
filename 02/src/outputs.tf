output "ip_address_vm1" {
  value = tomap({(var.vm_web_name) = (yandex_compute_instance.platform.network_interface.0.nat_ip_address)})
}

output "ip_address_vm2" {
  value = tomap({(var.vm_db_name) = (yandex_compute_instance.platform-db.network_interface.0.nat_ip_address)})
}