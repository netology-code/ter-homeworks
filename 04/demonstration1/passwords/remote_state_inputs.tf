data "terraform_remote_state" "vms" {
  backend = "local"

  config = {

  path="../vms/terraform.tfstate"
  }
}

locals{
    vms=data.terraform_remote_state.vms.outputs.out
}