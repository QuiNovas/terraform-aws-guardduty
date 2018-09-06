variable "account_name" {
  description = "The account name. Used to as a prefix to name resources."
  type        = "string"
}

variable "threat_intel_set_active" {
  default = true
}

variable "threat_intel_set_format" {
  default = "TXT"
  type        = "string"
}

variable "ip_set_active" {
  default = true
}

variable "ip_set_format" {
  default = "TXT"
  type        = "string"
}

variable "enable" {
  description = "Enable/Disable guardduty.You can set the enable attribute to false for suspend monitoring and feedback reporting while keeping existing data."
  type = "string"
  default = "true"
}

variable "log_bucket" {
  type = "string"
}

variable "threat_intel_list" {
  default = []
  type    = "list"
}

variable "ip_set_list" {
  default = []
  type    = "list"
}