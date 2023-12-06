pipeline "check_cidr_block" {
  title       = "Check CIDR Block"
  description = "Get information about IPs in a CIDR block."

  param "cred" {
    type        = string
    description = "Name for credentials to use. If not provided, the default credentials will be used."
    default = "default"
  }

  param "cidr" {
    type        = string
    description = "CIDR notation specifying the IPv4 or IPv6 range."
  }

  param "max_age_in_days" {
    type        = number
    description = "Maximum age in days for the reports to retrieve. Defaults to 30 days."
    default     = 30
  }

  step "http" "check_cidr_block" {
    method = "get"
    url    = "https://api.abuseipdb.com/api/v2/check-block"

    request_headers = {
      Key          = credential.abuseipdb[param.cred].api_key
      Content-Type = "application/json"
    }

    request_body = jsonencode({
      network      = param.cidr
      maxAgeInDays = param.max_age_in_days
    })
  }

  output "cidr_block_report" {
    description = "CIDR report details."
    value       = step.http.check_cidr_block.response_body.data
  }
}
