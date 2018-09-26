output "account_id" {
  description = ""
  value       = "${aws_guardduty_detector.master.account_id}"
}

output "id" {
  description = ""
  value       = "${aws_guardduty_detector.master.id}"
}
