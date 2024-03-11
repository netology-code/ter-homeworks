locals{
  ssh_settings = {
    serial-port-enable = 1
    ssh-keys  = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
  vm_web_name = "${var.company}-${var.environment}-${var.project_name}-${var.vm_role[0]}"
}