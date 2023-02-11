variable "token"{ 
  type = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id"{ 
  type = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id"{ 
  type = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}


###example vm_web var
variable "vm_web_name" { 
  type = string
  default = "netology-develop-platform-web"
  description = "example vm_web_ prefix"
}

###example vm_db var
variable "vm_db_name" { 
  type = number
  default = "netology-develop-platform-db"
  description = "example vm_db_ prefix"
}
