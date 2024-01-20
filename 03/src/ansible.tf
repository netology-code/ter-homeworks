resource "local_file" "hosts_cfg" {
  content  = templatefile("${path.module}/hosts.tftpl", {
    webservers = [for instance in yandex_compute_instance.web : {
      name = instance.name
      network_interface = instance.network_interface[0].nat_ip_address
    }],
    databases  = [for instance in [yandex_compute_instance.task_3] : {
      name = instance.name
      network_interface = instance.network_interface[0].nat_ip_address
    }]
  })
  filename = "${abspath(path.module)}/hosts.cfg"
}
