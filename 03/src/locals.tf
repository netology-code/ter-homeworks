locals {
    ssh_pub_key = file("~/.ssh/id_ed25519.pub")
    ssh_key = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
}