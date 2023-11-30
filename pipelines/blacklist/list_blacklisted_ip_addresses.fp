pipeline "list_blacklisted_ip_addresses" {
  title       = "List Blacklisted IP Addresses"
  description = "Get a list of the most reported IP addresses with an abuse confidence score above a minimum."

  param "api_key" {
    type        = string
    description = local.api_key_param_description
    default     = var.api_key
  }

  param "confidence_minimum" {
    type        = number
    description = "Minimum confidence score. Defaults to 90."
    default     = 90
  }

  step "http" "list_blacklisted_ip_addresses" {
    method = "get"
    url    = "https://api.abuseipdb.com/api/v2/blacklist"

    request_headers = {
      Key          = param.api_key
      Content-Type = "application/json"
    }

    request_body = jsonencode({
      confidenceMinimum = param.confidence_minimum
    })
  }

  output "blacklisted_ip_addresses" {
    description = "Blacklist details."
    value       = step.http.list_blacklisted_ip_addresses.response_body
  }
}
