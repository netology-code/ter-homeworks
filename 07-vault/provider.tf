terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = ">= 3.0.0"
    }
  }
}

provider "vault" {
  address = "http://localhost:8200"
}
