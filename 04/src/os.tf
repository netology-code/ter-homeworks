module "object_storage_develop" {
  source         = "git::https://github.com/terraform-yc-modules/terraform-yc-s3.git"
  
  bucket_name    = var.s3_dev_mod.bucket_name
  max_size       = var.s3_dev_mod.max_size
}