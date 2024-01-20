resource "local_file" "hosts_cfg" {
  content  = templatefile("${path.module}/hosts.tftpl", {
    webservers = yandex_compute_instance.web,
    databases  = yandex_compute_instance.db,
    storage  = [
      yandex_compute_instance.task_3.name,
      yandex_compute_instance.task_3.network_interface[0].nat_ip_address
    ]
  })
  filename = "${abspath(path.module)}/hosts.cfg"
}
