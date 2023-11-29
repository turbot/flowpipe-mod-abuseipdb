
# https://docs.abuseipdb.com/?shell#blacklist-endpoint


curl -G https://api.abuseipdb.com/api/v2/blacklist?ipVersion=6 \
  -H "Key: bfc6f1c423b8b58f9eb6fd715e327b26977977b2bad9ac4a56b8e49a85cda98f313c3d389126de0d"

# Plaintext Blacklist
curl -G https://api.abuseipdb.com/api/v2/blacklist \
  -H "Key: bfc6f1c423b8b58f9eb6fd715e327b26977977b2bad9ac4a56b8e49a85cda98f313c3d389126de0d" \
  -H "Accept: application/json"

# REPORT Endpoint
  Reporting IP addresses is the core feature of AbuseIPDB. When you report what you observe, everyone benefits, including yourself. To report an IP address, send a POST request. At least one category is required, but you may add additional categories using commas to separate the integer IDs. Related details can be included in the comment field
## POST the submission.
curl https://api.abuseipdb.com/api/v2/report \
  --data-urlencode "ip=127.0.0.1" \
  -d categories=18,22 \
  --data-urlencode "comment=SSH login attempts with user root." \
  --data-urlencode "timestamp=2023-10-18T11:25:11-04:00" \
  -H "Key: YOUR_OWN_API_KEY" \
  -H "Accept: application/json"


  curl --request POST \
  --url https://www.virustotal.com/api/v3/urls \
  -d 'url=https://turbot.com/guardrails' \
  --header 'x-apikey: 210b869a546983ff8b6ee5ea889ce100043ccbf2a71e16deb51441f5e6b96c52' \
  --header 'Content-Type: application/x-www-form-urlencoded'
