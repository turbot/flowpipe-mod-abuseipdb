// usage: flowpipe pipeline run check_ip --pipeline-arg ip_address='127.0.0.1'
pipeline "check_ip" {
  title       = "Check IP Address"
  description = "Get information about an IP (v4 or v6)."

  param "api_key" {
    type        = string
    default     = var.api_key
    description = "API key to authenticate requests with AbuseIPDB."
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

  step "http" "check_ip" {
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
    description = "IP Report details."
    value       = step.http.check_ip.response_body
  }
}
