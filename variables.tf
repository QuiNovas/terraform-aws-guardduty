variable "accept_invite" {
  description = "Accept invitation from a master account."
  default     = false
}

variable "accepter_master_account_id" {
  description = "Account ID for Guard Duty Master. Required if accept_invite = true"
  default     = ""
}

variable "account_name" {
  description = "The account name. Used as a prefix to name resources."
  type        = string
  default     = ""
}

variable "enable" {
  description = "Enable/Disable guardduty.You can set the enable attribute to false for suspend monitoring and feedback reporting while keeping existing data."
  default     = true
  type        = bool
}

variable "member_list" {
  default     = []
  description = "The list of member accounts to be added. Each member list need to have values of account_id, member_email and invite boolean"
  type = list(object({
    account_id   = string
    member_email = string
    invite       = bool
  }))
}

variable "ip_set_active" {
  description = "Specifies whether GuardDuty is to start using the uploaded IPSet"
  default     = false
  type        = bool
}

variable "ip_set_format" {
  description = "The format of the file that contains the IPSet. Valid values: TXT | STIX | OTX_CSV | ALIEN_VAULT | PROOF_POINT | FIRE_EYE"
  default     = "TXT"
  type        = string
}

variable "ip_set_list_path" {
  description = "The path of the IP safe list file"
  default     = ""
  type        = string
}

variable "log_bucket" {
  description = "Account level Log bucket id"
  type        = string
  default     = ""
}

variable "threat_intel_set_active" {
  description = "Specifies whether GuardDuty is to start using the uploaded ThreatIntelSet"
  default     = false
  type        = bool
}

variable "threat_intel_set_format" {
  description = "The format of the file that contains the ThreatIntelSet. Valid values: TXT | STIX | OTX_CSV | ALIEN_VAULT | PROOF_POINT | FIRE_EYE"
  default     = "TXT"
  type        = string
}

variable "threat_intel_list_path" {
  description = "The path of the Threat intel file"
  default     = ""
  type        = string
}

