resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/hosts.tftpl", 
  { 
  webservers = yandex_compute_instance.example,
  databases = yandex_compute_instance.root,
  storage = [yandex_compute_instance.storage],
  }
  )

  filename = "${abspath(path.module)}/hosts.ini"
}