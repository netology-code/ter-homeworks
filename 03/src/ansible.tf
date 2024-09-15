resource "local_file" "hosts_templatefile" {
  content = templatefile(
    "${path.module}/hosts.tftpl", 
    { 
        group_hosts = tolist(
            [
                {
                    group = "webservers"
                    hosts = yandex_compute_instance.vms-web[*]
                },
                {
                    group = "databases"
                    hosts = values(yandex_compute_instance.vms-db)
                },
                {
                    group = "storage"
                    hosts = yandex_compute_instance.vms-web-with-volume[*]
                }
            ]
        )
    }
  )

  filename = "${abspath(path.module)}/hosts.ini"
}
