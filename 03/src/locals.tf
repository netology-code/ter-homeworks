locals {
    metadata = {
        ssh-keys="ubuntu:${file("~/.ssh/decimal.pub")}"
    }
}