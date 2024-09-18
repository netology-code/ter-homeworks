locals {
    sa_key_file = file("~/.yc-bender-key.json")
    ssh_pub_key = file("~/.ssh/id_ed25519.pub")
    cloudinit = templatefile("${path.module}/cloud-init.yml", {
        ssh_public_key = local.ssh_pub_key
    })
}