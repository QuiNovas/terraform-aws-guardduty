output "id" {
  value = "${aws_guardduty_detector.master.id}"
}

output "account_id" {
  value = "${aws_guardduty_detector.master.account_id}"
}