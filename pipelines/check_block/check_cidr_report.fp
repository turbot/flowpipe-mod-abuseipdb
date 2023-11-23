# usage: flowpipe pipeline run check_cidr_report --arg cidr='127.0.0.1/24'
pipeline "check_cidr_report" {
  title       = "Check CIDR Range Report"
  description = "Get information about IPs in a CIDR range."

  param "api_key" {
    type        = string
    default     = var.api_key
    description = local.api_key_param_description
  }

  param "cidr" {
    type        = string
    description = "CIDR notation specifying the IPv4 or IPv6 range."
  }

  param "max_age_in_days" {
    type        = number
    default     = 30
    description = "Maximum age in days for the reports to retrieve. Defaults to 30 days."
  }

  step "http" "check_cidr_report" {
    method = "get"
    url    = "https://api.abuseipdb.com/api/v2/check-block"

    request_headers = {
      Key          = param.api_key
      Content-Type = "application/json"
    }

    request_body = jsonencode({
      network      = param.cidr
      maxAgeInDays = param.max_age_in_days
    })
  }

  output "report" {
    description = "CIDR report details."
    value       = step.http.check_cidr_report.response_body
  }
}
