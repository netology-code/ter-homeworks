terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.158.0"
    }
  }
  required_version = "~>1.12.0"
}

provider "yandex" {
  cloud_id                 = "b1gn3ndpua1j6jaabf79"
  folder_id                = "b1gfu61oc15cb99nqmfe"
  service_account_key_file = file("~/.authorized_key.json")
}

# You can set TF_LOG to one of the log levels (in order of decreasing verbosity) TRACE, DEBUG, INFO, WARN or ERROR to change the verbosity of the logs.
# export TF_LOG=DEBUG
