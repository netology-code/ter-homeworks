resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/ansible.tftpl",

    { 
       web = yandex_compute_instance.web,
       vm = yandex_compute_instance.vm,
       mount-storage = yandex_compute_instance.mount-storage
    } 
  )

  filename = "${abspath(path.module)}/inventory"
} 