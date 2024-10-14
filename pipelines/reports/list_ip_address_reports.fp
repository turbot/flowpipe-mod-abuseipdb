pipeline "list_ip_address_reports" {
  title       = "List IP Address Reports"
  description = "Retrieves a list of abuse reports filed against a specific IP address."

  param "conn" {
    type        = connection.abuseipdb
    description = local.conn_param_description
    default     = connection.abuseipdb.default
  }

  param "ip_address" {
    type        = string
    description = "The IPv4 or IPv6 address to retrieve abuse reports for."
  }

  param "max_age_in_days" {
    type        = number
    description = "Limits the age of reports to retrieve. Defaults to 30 days."
    default     = 30
  }

  step "http" "list_ip_address_reports" {
    method = "get"
    url    = "https://api.abuseipdb.com/api/v2/reports"

    request_headers = {
      Content-Type = "application/json"
      Key          = param.conn.api_key
    }

    request_body = jsonencode({
      ipAddress    = param.ip_address
      maxAgeInDays = param.max_age_in_days
      perPage      = 100
    })

    loop {
      until = result.response_body.data.nextPageUrl == null
      url   = result.response_body.data.nextPageUrl
    }
  }

  output "reports" {
    description = "List of reports filed against the specified IP address."
    value       = flatten([for page, reports in step.http.list_ip_address_reports : reports.response_body.data.results])
  }
}
