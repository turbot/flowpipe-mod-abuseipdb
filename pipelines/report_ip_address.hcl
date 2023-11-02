pipeline "report_ip_address" {
  title       = "Report IP Address"
  description = "Submit a report for suspicious or malicious activity from an IP address."

  param "api_key" {
    type        = string
    default     = var.api_key
    description = "API key to authenticate requests with AbuseIPDB."
  }

  param "offending_ip_address" {
    type        = string
    description = "The IPv4 or IPv6 address that the report is being filed against."
  }

  param "categories" {
    type        = list(number)
    description = "List of abuse categories. Refer to https://www.abuseipdb.com/categories for a full list."
  }

  param "comment" {
    type        = string
    optional    = true
    description = "A detailed description of the abusive behavior, including any relevant logs or evidence."
  }

  param "timestamp" {
    type        = string
    optional    = true
    description = "The date and time of the observed abuse in ISO 8601 format (YYYY-MM-DDThh:mm:ss)."
  }

  step "http" "report_ip_address" {
    method = "post"
    url    = "https://api.abuseipdb.com/api/v2/report"

    request_headers = {
      Key          = param.api_key
      Content-Type = "application/json"
    }

    request_body = param.timestamp != null ? jsonencode({
      ip         = param.offending_ip_address
      categories = param.categories
      comment    = param.comment
      timestamp  = param.timestamp
      }) : jsonencode({
      ip         = param.offending_ip_address
      categories = param.categories
      comment    = param.comment
    })
  }

  output "abuse_report" {
    description = "Confirmation and details of the submitted abuse report."
    value       = step.http.report_ip_address.response_body
  }
}
