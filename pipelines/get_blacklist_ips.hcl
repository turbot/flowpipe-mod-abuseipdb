pipeline "get_blacklist_ips" {
  title       = "Get Blacklist IPs"
  description = "Get a list of the most reported IP addresses with an abuse confidence score above a minimum."

  param "api_key" {
    type        = string
    default     = var.api_key
    description = "API key to authenticate requests with AbuseIPDB."
  }

  param "confidence_minimum" {
    type        = number
    default     = 90
    description = "Minimum confidence score. Defaults to 90."
  }

  step "http" "get_blacklist_ips" {
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

  output "blacklist" {
    description = "Blacklist details."
    value       = step.http.get_blacklist_ips.response_body
  }
}
