pipeline "endpoint_reports" {
  description = "Reports endpoint."

  param "api_key" {
    type    = string
    default = var.api_key
  }

  param "ip_address" {
    type    = string
    default = var.ip_address
  }

  step "http" "endpoint_reports" {
    method = "get"
    url    = "https://api.abuseipdb.com/api/v2/reports"

    request_headers = {
      Key          = param.api_key
      Content-Type = "application/json"
    }

    request_body = jsonencode({
      ipAddress = param.ip_address

    })
  }

  output "ip_report" {
    description = "Detailed IP address report."
    value       = step.http.endpoint_reports.response_body
  }
}
