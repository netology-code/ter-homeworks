terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"
}

provider "yandex" {
  #token                    = "do not use!!!"
  cloud_id                 = "b1gn3ndpua1j6jaabf79"
  folder_id                = "b1gfu61oc15cb99nqmfe"
  service_account_key_file = file("~/authorized_key.json")
  zone                     = "ru-central1-a" #(Optional) The default availability zone to operate under, if not specified by a given resource.
}

# You can set TF_LOG to one of the log levels (in order of decreasing verbosity) TRACE, DEBUG, INFO, WARN or ERROR to change the verbosity of the logs.
# export TF_LOG=DEBUG
