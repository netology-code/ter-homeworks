output "out" {
  value = concat(
    module.marketing_vm.fqdn,
    module.analytics_vm.fqdn
  )
}

