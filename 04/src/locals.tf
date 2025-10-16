locals {
    ssh_key = file("~/.ssh/decimal.pub")
    template_file = file("./cloud-init.yml")
}