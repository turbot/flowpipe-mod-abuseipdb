pipeline "list_reports" {
  title       = "List Reports"
  description = "Retrieves a list of abuse reports filed against a specific IP address."

  param "api_key" {
    type        = string
    default     = var.api_key
    description = "API key to authenticate requests with AbuseIPDB."
  }

  param "ip_address" {
    type        = string
    description = "The IPv4 or IPv6 address to retrieve abuse reports for."
  }

  param "max_age_in_days" {
    type        = number
    default     = 30
    optional    = true
    description = "Limits the age of reports to retrieve. Defaults to 30 days."
  }

  param "page" {
    type        = number
    default     = 1
    optional    = true
    description = "The page number of results to retrieve. Defaults to page 1."
  }

  param "per_page" {
    type        = number
    default     = 25
    optional    = true
    description = "The number of reports per page. Defaults to 25 reports per page."
  }

  step "http" "list_reports" {
    method = "get"
    url    = "https://api.abuseipdb.com/api/v2/reports"

    request_headers = {
      Key          = param.api_key
      Content-Type = "application/json"
    }

    request_body = jsonencode({
      ipAddress = param.ip_address
      page      = param.page
      perPage   = param.per_page
    })
  }

  output "reports" {
    description = "List of reports filed against the specified IP address."
    value       = step.http.list_reports.response_body
  }
}
