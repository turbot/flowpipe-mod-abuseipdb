pipeline "list_reports" {
  title       = "List Reports"
  description = "Retrieves a list of abuse reports filed against a specific IP address."

  param "api_key" {
    type        = string
    default     = var.api_key
    description = local.api_key_param_description
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

  param "per_page" {
    type        = number
    description = "Limits the number of data per page."
    default     = 100
  }

  step "http" "list_reports" {
    method = "get"
    url    = "https://api.abuseipdb.com/api/v2/reports"

    request_headers = {
      Key          = param.api_key
      Content-Type = "application/json"
    }

    request_body = jsonencode({
      ipAddress    = param.ip_address
      maxAgeInDays = param.max_age_in_days
      perPage      = param.per_page
    })

    loop {
      until = result.response_body.data.nextPageUrl == null
      url   = result.response_body.data.nextPageUrl
    }
  }

  output "reports" {
    description = "List of reports filed against the specified IP address."
    value       = flatten([for page, reports in step.http.list_reports : reports.response_body.data.results])
  }
}
