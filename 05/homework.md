## Задание 1

# TFLint

```tflint
Warning: Module source "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main" uses a default branch as ref (main) (terraform_module_pinned_source)

  on main.tf line 12:
  12:   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
```

```tflint
Warning: Missing version constraint for provider "template" in `required_providers` (terraform_required_providers)

  on main.tf line 69:
  69: data "template_file" "cloudinit" {
```

```tflint
Warning: Missing version constraint for provider "yandex" in `required_providers` (terraform_required_providers)

  on providers.tf line 3:
   3:     yandex = {
   4:       source = "yandex-cloud/yandex"
   5:     }
```

# Checkov

```checkov
Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
        FAILED for resource: marketing_vm
        File: /main.tf:11-31
```

```checkov
Check: CKV_TF_2: "Ensure Terraform module sources use a tag with a version number"
        FAILED for resource: marketing_vm
        File: /main.tf:11-31
```

```checkov
Check: CKV_YC_2: "Ensure compute instance does not have public IP."
        FAILED for resource: module.devops.yandex_compute_instance.devops["dev"]
        File: /vps/main.tf:14-43
        Calling File: /main.tf:56-67
```

```checkov
Check: CKV_YC_11: "Ensure security group is assigned to network interface."
        FAILED for resource: module.devops.yandex_compute_instance.devops["dev"]
        File: /vps/main.tf:14-43
        Calling File: /main.tf:56-67
```

## Задание 2

![alt text](image-4.png)

[Документация terraform-docs (ссылка на github repo)](https://github.com/gaidarvu/ter-homeworks/blob/terraform-04/04/src/spec.md)

## Задание 3

Смотрим модули, цепляем id модулей, которые будем удалять и удаляем
![alt text](image-3.png)

Импортируем обратно модули
![alt text](image-5.png)
![alt text](image-6.png)

Смотрим terraform plan
![alt text](image-7.png)

[Финальный код (ссылка на github repo)](https://github.com/gaidarvu/ter-homeworks/tree/terraform-04/04/src)
