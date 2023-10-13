pipeline "check_endpoint" {
  description = "Check IP address."

  param "api_key" {
    type    = string
    default = var.api_key
  }

  param "ip_address" {
    type    = string
    default = var.ip_address
  }

  param "max_age_in_days" {
    type    = string
    default = var.max_age_in_days
  }

  step "http" "check_endpoint" {
    method = "get"
    url    = "https://api.abuseipdb.com/api/v2/check"

    request_headers = {
      "Key"          = param.api_key
      "Content-Type" = "application/json"
    }

    request_body = jsonencode({
      ipAddress    = param.ip_address
      maxAgeInDays = param.max_age_in_days
    })

  }


  output "ip_report" {
    description = "Report related to IP address."
    value       = step.http.check_endpoint.response_body
  }
}
