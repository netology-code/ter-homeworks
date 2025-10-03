locals {
    ssh_key = "${file("~/.ssh/decimal.pub")}"
}