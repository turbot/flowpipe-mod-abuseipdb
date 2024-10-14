pipeline "check_cidr_block" {
  title       = "Check CIDR Block"
  description = "Get information about IPs in a CIDR block."

  param "conn" {
    type        = connection.abuseipdb
    description = local.conn_param_description
    default     = connection.abuseipdb.default
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
      Content-Type = "application/json"
      Key          = param.conn.api_key
    }

    request_body = jsonencode({
      maxAgeInDays = param.max_age_in_days
      network      = param.cidr
    })
  }

  output "cidr_block_report" {
    description = "CIDR report details."
    value       = step.http.check_cidr_block.response_body.data
  }
}
