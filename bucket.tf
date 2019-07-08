


data "aws_caller_identity" "current" {
}

locals {
  bucket_creation_count = var.threat_intel_list_path == "" && var.ip_set_list_path == "" ? 0 : 1
}

data "aws_s3_bucket" "log_bucket" {
  count  = local.bucket_creation_count && length(var.log_bucket) > 1 ? 1 : 0
  bucket = var.log_bucket
}

resource "aws_s3_bucket" "guard_duty_lists" {
  count  = local.bucket_creation_count
  bucket = "${local.account_name}-guardduty-lists"

  lifecycle {
    prevent_destroy = true
  }

  logging {
    target_bucket = data.aws_s3_bucket.log_bucket[0].id
    target_prefix = "s3/guard_duty/"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }
}

data "aws_iam_policy_document" "guard_duty_lists" {
  statement {
    actions = [
      "s3:*",
    ]

    condition {
      test = "Bool"

      values = [
        "false",
      ]

      variable = "aws:SecureTransport"
    }

    effect = "Deny"

    principals {
      identifiers = [
        "*",
      ]

      type = "AWS"
    }

    resources = [
      element(concat(aws_s3_bucket.guard_duty_lists.*.arn, [""]), 0),
      "${element(concat(aws_s3_bucket.guard_duty_lists.*.arn, [""]), 0)}/*",
    ]

    sid = "DenyUnsecuredTransport"
  }
}

resource "aws_s3_bucket_policy" "guard_duty_lists" {
  count  = var.threat_intel_list_path == "" && var.ip_set_list_path == "" ? 0 : 1
  bucket = aws_s3_bucket.guard_duty_lists[0].id
  policy = data.aws_iam_policy_document.guard_duty_lists.json
}

