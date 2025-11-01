# Общие теги/метки для всех ресурсов
# Можно импортировать в стеки через: import { source = "/imports/common-tags.tm.hcl" }

generate_hcl "common-locals.tf" {
  content {
    locals {
      common_tags = {
        managed_by = "terramate"
        project    = "netology-homework"
      }
    }
  }
}

