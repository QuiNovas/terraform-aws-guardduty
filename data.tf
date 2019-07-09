data "aws_caller_identity" "current" {
}

data "aws_s3_bucket" "log_bucket" {
  count  = local.bucket_creation_count > 0 && length(var.log_bucket) > 1 ? 1 : 0
  bucket = var.log_bucket
}
