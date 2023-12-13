pipeline "list_blacklisted_ip_addresses" {
  title       = "List Blacklisted IP Addresses"
  description = "Get a list of the most reported IP addresses with an abuse confidence score above a minimum."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "confidence_minimum" {
    type        = number
    description = "Minimum confidence score. Minimum is 25 and maximum is 100. Defaults to 90."
    default     = 90
  }

  step "http" "list_blacklisted_ip_addresses" {
    method = "get"
    url    = "https://api.abuseipdb.com/api/v2/blacklist"

    request_headers = {
      Content-Type = "application/json"
      Key          = credential.abuseipdb[param.cred].api_key
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
