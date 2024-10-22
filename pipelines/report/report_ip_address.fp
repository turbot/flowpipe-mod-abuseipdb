pipeline "report_ip_address" {
  title       = "Report IP Address"
  description = "Submit a report for suspicious or malicious activity from an IP address."

  tags = {
    type = "recommended"
  }

  param "conn" {
    type        = connection.abuseipdb
    description = local.conn_param_description
    default     = connection.abuseipdb.default
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
      Content-Type = "application/json"
      Key          = param.conn.api_key
    }

    request_body = param.timestamp != null ? jsonencode({
      categories = param.categories
      comment    = param.comment
      ip         = param.offending_ip_address
      timestamp  = param.timestamp
      }) : jsonencode({
      categories = param.categories
      comment    = param.comment
      ip         = param.offending_ip_address
    })

  }

  output "ip_address" {
    description = "Confirmation and details of the submitted abuse report."
    value       = step.http.report_ip_address.response_body
  }
}
