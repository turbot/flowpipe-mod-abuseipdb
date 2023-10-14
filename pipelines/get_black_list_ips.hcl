pipeline "get_black_list_ips" {
  description = "Retrieve list of the most reported IP addresses."

  param "api_key" {
    type    = string
    default = var.api_key
  }

  step "http" "get_black_list_ips" {
    method = "get"
    url    = "https://api.abuseipdb.com/api/v2/blacklist"

    request_headers = {
      Key          = param.api_key
      Content-Type = "application/json"
    }

  }

  output "blacklist" {
    description = "Blacklist from AbuseIPDB."
    value       = step.http.get_black_list_ips.response_body
  }
}
