stack {
  name        = "dev"
  description = "Development environment"
  id          = "dev"
}

globals {
  env_name       = "develop"
  subnet_zones   = ["ru-central1-a", "ru-central1-b"]
  subnet_cidrs   = ["10.0.1.0/24", "10.0.2.0/24"]
  vm_count       = 2
  instance_name  = "webs"
  image_family   = "ubuntu-2004-lts"
  public_ip      = true
  
  labels = {
    owner   = "i.ivanov"
    project = "accounting"
    env     = "dev"
  }
}

import {
  source = "../../modules/yandex_cloud/vms/vms.tm.hcl"
}

