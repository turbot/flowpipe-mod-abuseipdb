# usage: flowpipe pipeline run check_ip_report --arg ip_address='127.0.0.1'
pipeline "check_ip_report" {
  title       = "Check IP Address Report"
  description = "Get information about an IP (v4 or v6)."

  param "api_key" {
    type        = string
    default     = var.api_key
    description = local.api_key_param_description
  }

  param "ip_address" {
    type        = string
    description = "The IPv4 or IPv6 address to check for reports."
  }

  param "max_age_in_days" {
    type        = number
    default     = 30
    description = "Maximum age in days for the reports to retrieve. Defaults to 30 days."
  }

  step "http" "check_ip_report" {
    method = "get"
    url    = "https://api.abuseipdb.com/api/v2/check"

    request_headers = {
      Key          = param.api_key
      Content-Type = "application/json"
    }

    request_body = jsonencode({
      ipAddress    = param.ip_address
      maxAgeInDays = param.max_age_in_days
    })
  }

  output "report" {
    description = "IP report details."
    value       = step.http.check_ip_report.response_body
  }
}
