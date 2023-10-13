pipeline "report_endpoint_abuse" {
  description = "Report an IP address to AbuseIPDB."

  param "api_key" {
    type    = string
    default = var.api_key
  }

  param "abuse_ip_address" {
    type    = string
    default = var.abuse_ip_address
  }

  param "categories" {
    type    = list(number)
    default = var.categories
  }

  param "comment" {
    type    = string
    default = var.comment
  }

  param "timestamp" {
    type    = string
    default = var.timestamp
  }

  step "http" "report_endpoint_abuse" {
    method = "post"
    url    = "https://api.abuseipdb.com/api/v2/report"

    request_headers = {
      Key          = param.api_key
      Content-Type = "application/json"
    }

    request_body = jsonencode({
      ip         = param.abuse_ip_address
      categories = param.categories
      comment    = param.comment
      timestamp  = param.timestamp
    })
  }

  output "abuse_result" {
    description = "Details of the IP address reported."
    value       = step.http.report_endpoint_abuse.response_body
  }
}
