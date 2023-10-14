variable "api_key" {
  type        = string
  description = "The api key token to authenticate to the AbuseIPDB APIs."
  default     = ""
}

variable "max_age_in_days" {
  type        = number
  description = "Max number of days data to check."
  default     = 30
}

variable "ip_address" {
  type        = string
  description = "Endpoint IP Address to check."
  default     = ""
}

variable "abuse_ip_address" {
  type        = string
  description = "Endpoint IP Address to report abuse."
  default     = ""
}

variable "categories" {
  type        = list(number)
  description = "Categories to check detail report of the Endpoint IP."
  default     = []
}

variable "comment" {
  type        = string
  description = "Comment to add as note to the generated report of specific IP."
  default     = ""
}

variable "timestamp" {
  type        = string
  description = "Timestamp of reporting IP abuse."
  default     = ""
}

