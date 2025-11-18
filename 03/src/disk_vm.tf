resource "yandex_compute_disk" "storage" {
  count = 3

  name     = "storage-disk-${count.index}"
  type     = "network-hdd"
  zone     = "ru-central1-a"
  size     = 1
}
