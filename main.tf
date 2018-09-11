data "aws_caller_identity" "current" {}

resource "aws_iam_service_linked_role" "guardduty" {
  aws_service_name = "guardduty.amazonaws.com"
}

resource "aws_iam_policy" "guardduty_full_access" {
  name        = "guardduty-full-access"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
               "guardduty:*"
            ],
            "Resource": "*"
        },      
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateServiceLinkedRole"
            ],
            "Resource": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/guardduty.amazonaws.com/AWSServiceRoleForAmazonGuardDuty",
            "Condition": {
                "StringLike": {
                    "iam:AWSServiceName": "guardduty.amazonaws.com"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:PutRolePolicy",
                "iam:DeleteRolePolicy"
            ],
            "Resource": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/guardduty.amazonaws.com/AWSServiceRoleForAmazonGuardDuty"
        }
    ]
} 
EOF
}

resource "aws_iam_policy_attachment" "guardduty" {
  name       = "guardduty-attachment"
  roles      = ["${aws_iam_service_linked_role.guardduty.name}"]
  policy_arn = "${aws_iam_policy.guardduty_full_access.arn}"
}
resource "aws_guardduty_detector" "master" {
  enable = "${var.enable}"
}

resource "aws_s3_bucket_object" "MyThreatIntelSet" {
  content = "${var.threat_intel_list}"
  bucket  = "${aws_s3_bucket.guard_duty_lists.id}"
  key     = "MyThreatIntelSet"
}

resource "aws_guardduty_threatintelset" "MyThreatIntelSet" {
  activate    = "${var.threat_intel_set_active}"
  detector_id = "${aws_guardduty_detector.master.id}"
  format      = "${var.threat_intel_set_format}"
  location    = "https://s3.amazonaws.com/${aws_s3_bucket_object.MyThreatIntelSet.bucket}/${aws_s3_bucket_object.MyThreatIntelSet.key}"
  name        = "MyThreatIntelSet"
}

resource "aws_s3_bucket_object" "MyIPSet" {
  content = "${var.threat_intel_list}"
  bucket  = "${aws_s3_bucket.guard_duty_lists.id}"
  key     = "MyIPSet"
}

resource "aws_guardduty_ipset" "MyIPSet" {
  activate    = "${var.ip_set_active}"
  detector_id = "${aws_guardduty_detector.master.id}"
  format      = "${var.ip_set_format}"
  location    = "https://s3.amazonaws.com/${aws_s3_bucket_object.MyIPSet.bucket}/${aws_s3_bucket_object.MyIPSet.key}"
  name        = "MyIPSet"
}
