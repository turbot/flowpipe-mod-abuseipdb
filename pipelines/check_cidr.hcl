// usage: flowpipe pipeline run check_cidr --pipeline-arg cidr='127.0.0.1/24'
pipeline "check_cidr" {
  title       = "Check CIDR Range"
  description = "Get information about IPs in a CIDR range."

  param "api_key" {
    type        = string
    default     = var.api_key
    description = "API key to authenticate requests with AbuseIPDB."
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

  step "http" "check_cidr" {
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
    description = "CIDR Report details."
    value       = step.http.check_cidr.response_body
  }
}
