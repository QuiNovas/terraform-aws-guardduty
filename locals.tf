locals {
  account_name = length(var.account_name) > 0 ? var.account_name : data.aws_caller_identity.current.account_id
}

