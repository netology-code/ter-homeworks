output "all_vms" {
  description = "List of all VMs as dictionaries"
  value = concat(
    # ВМ из count (web-1, web-2)
    [
      for vm in yandex_compute_instance.web : {
        name = vm.name
        id   = vm.id
        fqdn = vm.fqdn
      }
    ],
    # ВМ из for_each (main, replica)
    [
      for vm_key, vm in yandex_compute_instance.database_vm : {
        name = vm.name
        id   = vm.id
        fqdn = vm.fqdn
      }
    ],
    # ВМ storage
    [
      {
        name = yandex_compute_instance.storage.name
        id   = yandex_compute_instance.storage.id
        fqdn = yandex_compute_instance.storage.fqdn
      }
    ]
  )
}
