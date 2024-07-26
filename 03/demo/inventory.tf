resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/hosts.tftpl",

  { webservers = yandex_compute_instance.example })

  filename = "${abspath(path.module)}/hosts.cfg"
}

resource "local_file" "hosts_for" {
  content =  <<-EOT
  %{if length(yandex_compute_instance.example) > 0}
  [webservers]
  %{endif}
  %{for i in yandex_compute_instance.example }
  ${i["name"]}   ansible_host=${i["network_interface"][0]["nat_ip_address"]}
  %{endfor}
  EOT
  filename = "${abspath(path.module)}/for.cfg"

}
