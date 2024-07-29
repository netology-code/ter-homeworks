output "out" {

    value={ for k,v in random_password.input_vms: k=>nonsensitive(v.result) }
}
