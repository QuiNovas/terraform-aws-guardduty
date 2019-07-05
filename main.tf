resource "aws_guardduty_detector" "master" {
  enable = "${var.enable}"
}

resource "aws_s3_bucket_object" "MyThreatIntelSet" {
  count  = "${var.threat_intel_list_path == "" ? 0 : 1}"
  bucket = "${aws_s3_bucket.guard_duty_lists.id}"
  key    = "MyThreatIntelSet.txt"
  source = "${var.threat_intel_list_path}"
  etag   = "${md5(file("${var.threat_intel_list_path}"))}"
}

resource "aws_guardduty_threatintelset" "MyThreatIntelSet" {
  count       = "${var.threat_intel_list_path== "" ? 0 : 1}"
  activate    = "${var.threat_intel_set_active}"
  detector_id = "${aws_guardduty_detector.master.id}"
  format      = "${var.threat_intel_set_format}"
  location    = "https://s3.amazonaws.com/${aws_s3_bucket_object.MyThreatIntelSet.bucket}/${aws_s3_bucket_object.MyThreatIntelSet.key}"
  name        = "MyThreatIntelSet"
}

resource "aws_s3_bucket_object" "MyIPSet" {
  count  = "${var.ip_set_list_path == "" ? 0 : 1}"
  bucket = "${aws_s3_bucket.guard_duty_lists.id}"
  key    = "MyIPSet.txt"
  source = "${var.ip_set_list_path}"
  etag   = "${md5(file("${var.ip_set_list_path}"))}"
}

resource "aws_guardduty_ipset" "MyIPSet" {
  count       = "${var.ip_set_list_path == "" ? 0 : 1}"
  activate    = "${var.ip_set_active}"
  detector_id = "${aws_guardduty_detector.master.id}"
  format      = "${var.ip_set_format}"
  location    = "https://s3.amazonaws.com/${aws_s3_bucket_object.MyIPSet.bucket}/${aws_s3_bucket_object.MyIPSet.key}"
  name        = "MyIPSet"
}

resource "aws_guardduty_member" "members" {
  count              = "${var.member_list_count}"
  account_id         = "${lookup(var.member_list[count.index], "account_id")}"
  detector_id        = "${aws_guardduty_detector.master.id}"
  email              = "${lookup(var.member_list[count.index], "member_email")}"
  invite             = "${lookup(var.member_list[count.index], "invite")}"
  invitation_message = "please accept guardduty invitation"
}

resource "aws_guardduty_invite_accepter" "member_accepter" {
  count             = "${var.accept_invite && (length(var.accepter_master_account_id) > 0) ? 1 : 0}"
  detector_id       = "${aws_guardduty_detector.master.id}"
  master_account_id = "${var.accepter_master_account_id}"
}
