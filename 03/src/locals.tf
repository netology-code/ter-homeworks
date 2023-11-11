locals {
  ssh_id_rsa = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
}