resource "aws_guardduty_detector" "master" {
  enable = "${var.enable}"
}

resource "aws_s3_bucket_object" "MyThreatIntelSet" {
  bucket  = "${aws_s3_bucket.guard_duty_lists.id}"
  key     = "MyThreatIntelSet.txt"
  source = "${var.threat_intel_list_path}"
  etag   = "${md5(file("${var.threat_intel_list_path}"))}"
}

resource "aws_guardduty_threatintelset" "MyThreatIntelSet" {
  activate    = "${var.threat_intel_set_active}"
  detector_id = "${aws_guardduty_detector.master.id}"
  format      = "${var.threat_intel_set_format}"
  location    = "https://s3.amazonaws.com/${aws_s3_bucket_object.MyThreatIntelSet.bucket}/${aws_s3_bucket_object.MyThreatIntelSet.key}"
  name        = "MyThreatIntelSet"
}

resource "aws_s3_bucket_object" "MyIPSet" {
  bucket  = "${aws_s3_bucket.guard_duty_lists.id}"
  key     = "MyIPSet.txt"
  source = "${var.ip_set_list_path}"
  etag   = "${md5(file("${var.ip_set_list_path}"))}"
}

resource "aws_guardduty_ipset" "MyIPSet" {
  activate    = "${var.ip_set_active}"
  detector_id = "${aws_guardduty_detector.master.id}"
  format      = "${var.ip_set_format}"
  location    = "https://s3.amazonaws.com/${aws_s3_bucket_object.MyIPSet.bucket}/${aws_s3_bucket_object.MyIPSet.key}"
  name        = "MyIPSet"
}
