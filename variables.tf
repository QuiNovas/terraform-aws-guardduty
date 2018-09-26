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
  description = ""
  default     = true
  type        = "string"
}

variable "ip_set_format" {
  description = ""
  default     = "TXT"
  type        = "string"
}

variable "ip_set_list" {
  description = ""
  default     = ""
  type        = "string"
}

variable "log_bucket" {
  description = ""
  type        = "string"
  type        = "string"
}

variable "threat_intel_set_active" {
  description = ""
  default     = true
  type        = "string"
}

variable "threat_intel_set_format" {
  description = ""
  default     = "TXT"
  type        = "string"
}

variable "threat_intel_list" {
  description = ""
  default     = ""
  type        = "string"
}
