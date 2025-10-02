output "vm_idents" {
  value = concat(
    [
      for instance in yandex_compute_instance.web : {
        name = instance.name
        id   = instance.id
        fdqn = instance.fqdn
      }
    ],
    [
      for instance in yandex_compute_instance.db : {
        name = instance.name
        id   = instance.id
        fdqn = instance.fqdn
      }
    ]
  )
}