output "instance_name" { 
  value = yandex_compute_instance.*.name
}

output "fqdn" {
  value = yandex_compute_instance.*.hostname
}

output "external_ip" {
  value = yandex_vpc_address.*.external_ipv4_address.0.address
}
