data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {
    path = "../vpc/terraform.tfstate"
  }

  outputs = ["remote_state_outputs"]
}

locals {
  network_id = data.terraform_remote_state.vpc.outputs.remote_state_outputs.network_id
  subnet_ids = data.terraform_remote_state.vpc.outputs.remote_state_outputs.subnet_ids
}
