output "account_id" {
  description = "The AWS account ID of the GuardDuty detector"
  value       = aws_guardduty_detector.master.account_id
}

output "id" {
  description = "The ID of the GuardDuty detector"
  value       = aws_guardduty_detector.master.id
}

