stack {
  name        = "prod"
  description = "Production environment"
  id          = "prod"
}

globals {
  env_name       = "prod"
  subnet_zones   = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
  subnet_cidrs   = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  vm_count       = 3
  instance_name  = "webs-prod"
  image_family   = "ubuntu-2004-lts"
  public_ip      = true
  
  labels = {
    owner   = "i.ivanov"
    project = "accounting"
    env     = "prod"
  }
}

import {
  source = "../../modules/yandex_cloud/vms/vms.tm.hcl"
}

