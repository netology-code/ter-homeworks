resource "local_file" "hosts_cfg" {
  content  = templatefile("${path.module}/hosts.tftpl", {
    webservers = yandex_compute_instance.web,
    databases  = yandex_compute_instance.db,
    storage  = local.web_instance
  })
  filename = "${abspath(path.module)}/hosts.cfg"
}


locals {
  web_instance = values(yandex_compute_instance.task_3)
}

