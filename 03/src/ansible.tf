resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl",

  { webservers = yandex_compute_instance.web })

  filename = "${abspath(path.module)}/hosts.cfg"
}