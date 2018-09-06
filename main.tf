resource "aws_guardduty_detector" "master" {
  enable = "{var.enable}"
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