pipeline "report_ip_address" {
  title       = "Report IP Address"
  description = "Submit a report for suspicious or malicious activity from an IP address."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
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
    description = "A detailed description of the abusive behavior, including any relevant logs or evidence."
    optional    = true
  }

  param "timestamp" {
    type        = string
    description = "The date and time of the observed abuse in ISO 8601 format (YYYY-MM-DDThh:mm:ss)."
    optional    = true
  }

  step "http" "report_ip_address" {
    method = "post"
    url    = "https://api.abuseipdb.com/api/v2/report"

    request_headers = {
      Key          = credential.abuseipdb[param.cred].api_key
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

  output "ip_address" {
    description = "Confirmation and details of the submitted abuse report."
    value       = step.http.report_ip_address.response_body
  }
}
