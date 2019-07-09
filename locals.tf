locals {
  account_name          = length(var.account_name) > 0 ? var.account_name : data.aws_caller_identity.current.account_id
  bucket_creation_count = var.threat_intel_list_path == "" && var.ip_set_list_path == "" ? 0 : 1
}

