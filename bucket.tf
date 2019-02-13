data "aws_caller_identity" "current" {}


data "aws_s3_bucket" "log_bucket" {
  bucket = "${var.log_bucket}"
}

locals {
  account_name = "${length(var.account_name) > 0 ? var.account_name : data.aws_caller_identity.current.account_id}"
}

resource "aws_s3_bucket" "guard_duty_lists" {
  count  = "${(var.threat_intel_list_path == "") || (var.ip_set_list_path == "")  ? 0 : 1}"
  bucket = "${local.account_name}-guardduty-lists"

  lifecycle {
    prevent_destroy = true
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.log_bucket.id}"
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
      "${element(concat(aws_s3_bucket.guard_duty_lists.*.arn, list("")), 0)}",
      "${element(concat(aws_s3_bucket.guard_duty_lists.*.arn, list("")), 0)}/*",
    ]

    sid = "DenyUnsecuredTransport"
  }
}
