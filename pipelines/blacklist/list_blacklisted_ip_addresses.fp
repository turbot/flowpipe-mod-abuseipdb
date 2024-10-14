pipeline "list_blacklisted_ip_addresses" {
  title       = "List Blacklisted IP Addresses"
  description = "Get a list of the most reported IP addresses with an abuse confidence score above a minimum."

  param "conn" {
    type        = connection.abuseipdb
    description = local.conn_param_description
    default     = connection.abuseipdb.default
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
      Key          = param.conn.api_key
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
