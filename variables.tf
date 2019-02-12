variable "account_name" {
  description = "The account name. Used as a prefix to name resources."
  type        = "string"
  default     = ""
}

variable "enable" {
  description = "Enable/Disable guardduty.You can set the enable attribute to false for suspend monitoring and feedback reporting while keeping existing data."
  default     = true
  type        = "string"
}

variable "member_list" {
  description = "The list of member accounts to be added. Each member list need to have values of account_id, member_email and invite boolean"
  type        = "list"
  default     = []
}

#example
#[
#    {
#      account_id = "12345678913"
#      member_email = "email@email.com"
#      invite = "true"
#    }
#  ]

variable "member_list_count" {
  description = "The count of members to be added to this master guard duty"
  type        = "string"
  default     = 0
}

variable "ip_set_active" {
  description = "Specifies whether GuardDuty is to start using the uploaded IPSet"
  default     = false
  type        = "string"
}

variable "ip_set_format" {
  description = "The format of the file that contains the IPSet. Valid values: TXT | STIX | OTX_CSV | ALIEN_VAULT | PROOF_POINT | FIRE_EYE"
  default     = "TXT"
  type        = "string"
}

variable "ip_set_list_path" {
  description = "The path of the IP safe list file"
  default     = ""
  type        = "string"
}

variable "log_bucket" {
  description = "Account level Log bucket id"
  type        = "string"
}

variable "threat_intel_set_active" {
  description = "Specifies whether GuardDuty is to start using the uploaded ThreatIntelSet"
  default     = false
  type        = "string"
}

variable "threat_intel_set_format" {
  description = "The format of the file that contains the ThreatIntelSet. Valid values: TXT | STIX | OTX_CSV | ALIEN_VAULT | PROOF_POINT | FIRE_EYE"
  default     = "TXT"
  type        = "string"
}

variable "threat_intel_list_path" {
  description = "The path of the Threat intel file"
  default     = ""
  type        = "string"
}
