resource "local_file" "hosts_cfg" {
  content  = templatefile("${path.module}/hosts.tftpl", {
    webservers = yandex_compute_instance.web,
    task_3 = yandex_compute_instance.task_3
  })
  filename = "${abspath(path.module)}/hosts.cfg"
}
