pipeline "check_ip_address" {
  title       = "Check IP Address"
  description = "Get information about an IP address (v4 or v6)."

  tags = {
    type = "recommended"
  }

  param "conn" {
    type        = connection.abuseipdb
    description = local.conn_param_description
    default     = connection.abuseipdb.default
  }

  param "ip_address" {
    type        = string
    description = "The IPv4 or IPv6 address to check for reports."
  }

  param "max_age_in_days" {
    type        = number
    description = "Maximum age in days for the reports to retrieve. Defaults to 30 days."
    default     = 30
  }

  step "http" "check_ip_address" {
    method = "get"
    url    = "https://api.abuseipdb.com/api/v2/check"

    request_headers = {
      Content-Type = "application/json"
      Key          = param.conn.api_key
    }

    request_body = jsonencode({
      ipAddress    = param.ip_address
      maxAgeInDays = param.max_age_in_days
    })
  }

  output "ip_report" {
    description = "IP address report details."
    value       = step.http.check_ip_address.response_body.data
  }
}
