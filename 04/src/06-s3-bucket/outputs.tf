output "s3_bucket_name" {
  description = "Name of the created S3 bucket"
  value       = yandex_storage_bucket.homework_bucket.bucket
}

output "s3_bucket_id" {
  description = "ID of the created S3 bucket"
  value       = yandex_storage_bucket.homework_bucket.id
}

output "service_account_name" {
  description = "Name of the service account"
  value       = yandex_iam_service_account.s3_sa.name
}

output "service_account_id" {
  description = "ID of the service account"
  value       = yandex_iam_service_account.s3_sa.id
}

output "access_key" {
  description = "Access key for S3 bucket"
  value       = yandex_iam_service_account_static_access_key.s3_sa_keys.access_key
  sensitive   = true
}

output "secret_key" {
  description = "Secret key for S3 bucket"
  value       = yandex_iam_service_account_static_access_key.s3_sa_keys.secret_key
  sensitive   = true
}

output "max_size" {
  description = "Maximum size of the bucket"
  value       = "${yandex_storage_bucket.homework_bucket.max_size} bytes (1 GB)"
}

output "bucket_url" {
  description = "URL for accessing the bucket"
  value       = "https://storage.yandexcloud.net/${yandex_storage_bucket.homework_bucket.bucket}"
}

output "usage_instructions" {
  description = "Instructions for using the S3 bucket"
  value       = <<EOT
S3 Bucket created successfully!

Bucket Name: ${yandex_storage_bucket.homework_bucket.bucket}
Access Key: ${yandex_iam_service_account_static_access_key.s3_sa_keys.access_key}
Secret Key: <hidden - use 'terraform output -raw secret_key' to view>

To use with AWS CLI or Terraform backend:
export AWS_ACCESS_KEY_ID=${yandex_iam_service_account_static_access_key.s3_sa_keys.access_key}
export AWS_SECRET_ACCESS_KEY=<secret_key>
export AWS_DEFAULT_REGION=ru-central1
export AWS_ENDPOINT_URL=https://storage.yandexcloud.net

For Terraform backend configuration, see the example in the documentation.
EOT
}
