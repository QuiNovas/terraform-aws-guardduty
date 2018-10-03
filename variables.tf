variable "account_name" {
  description = "The account name. Used to as a prefix to name resources."
  type        = "string"
}

variable "enable" {
  description = "Enable/Disable guardduty.You can set the enable attribute to false for suspend monitoring and feedback reporting while keeping existing data."
  default     = true
  type        = "string"
}

variable "ip_set_active" {
  description = "Specifies whether GuardDuty is to start using the uploaded IPSet"
  default     = true
  type        = "string"
}

variable "ip_set_format" {
  description = "The format of the file that contains the IPSet. Valid values: TXT | STIX | OTX_CSV | ALIEN_VAULT | PROOF_POINT | FIRE_EYE"
  default     = "TXT"
  type        = "string"
}

variable "ip_set_list" {
  description = "List of the IP's, the content of the MyIPSet that will uploaded to s3 bucket"
  default     = ""
  type        = "string"
}

variable "log_bucket" {
  description = "Account level Log bucket id"
  type        = "string"
}

variable "threat_intel_set_active" {
  description = "Specifies whether GuardDuty is to start using the uploaded ThreatIntelSet"
  default     = true
  type        = "string"
}

variable "threat_intel_set_format" {
  description = "The format of the file that contains the ThreatIntelSet. Valid values: TXT | STIX | OTX_CSV | ALIEN_VAULT | PROOF_POINT | FIRE_EYE"
  default     = "TXT"
  type        = "string"
}

variable "threat_intel_list" {
  description = "List of the IP's, the content of the MyThreatIntelSet that will uploaded to s3 bucket"
  default     = ""
  type        = "string"
}
