output "remote_state_outputs" {
  value = {
    network_id = yandex_vpc_network.develop.id
    subnet_ids = yandex_vpc_network.develop.subnet_ids
  }
}
