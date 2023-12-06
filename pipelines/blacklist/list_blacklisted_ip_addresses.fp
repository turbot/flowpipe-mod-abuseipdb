pipeline "list_blacklisted_ip_addresses" {
  title       = "List Blacklisted IP Addresses"
  description = "Get a list of the most reported IP addresses with an abuse confidence score above a minimum."

  param "cred" {
    type        = string
    description = "Name for credentials to use. If not provided, the default credentials will be used."
    default = "default"
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
      Key          = credential.abuseipdb[param.cred].api_key
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
