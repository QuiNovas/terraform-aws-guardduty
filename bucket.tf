resource "aws_s3_bucket" "guard_duty_lists" {
  bucket = "${var.account_name}-guardduty-lists"
  lifecycle {
    prevent_destroy = true
  }
  logging {
    target_bucket = "${data.aws_s3_bucket.log_bucket.id}"
    target_prefix = "s3/${var.distribution_name}/"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags   = "${local.tags}"
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
      "${aws_s3_bucket.guard_duty_lists.arn}",
      "${aws_s3_bucket.guard_duty_lists.arn}/*",
    ]

    sid = "DenyUnsecuredTransport"
  }
}