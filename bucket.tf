
resource "aws_s3_bucket" "guard_duty_lists" {
  count  = local.bucket_creation_count
  bucket = "${local.account_name}-guardduty-lists"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "guard_duty_lists_encryption" {
  count  = local.bucket_creation_count
  bucket = aws_s3_bucket.guard_duty_lists.0.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "guard_duty_lists_versioning" {
  count  = local.bucket_creation_count
  bucket = aws_s3_bucket.guard_duty_lists.0.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "guard_duty_lists_logging" {
  count  = local.bucket_creation_count
  bucket = aws_s3_bucket.guard_duty_lists.0.bucket

  target_bucket = data.aws_s3_bucket.log_bucket[0].id
  target_prefix = "s3/guard_duty/"
}


data "aws_iam_policy_document" "guard_duty_lists" {
  count = local.bucket_creation_count
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
  count  = local.bucket_creation_count
  bucket = aws_s3_bucket.guard_duty_lists[0].id
  policy = data.aws_iam_policy_document.guard_duty_lists[0].json
}