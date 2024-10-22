mod "abuseipdb" {
  title         = "AbuseIPDB"
  description   = "Run pipelines to supercharge your AbuseIPDB workflows using Flowpipe."
  color         = "#4e7e14"
  documentation = file("./README.md")
  icon          = "/images/mods/turbot/abuseipdb.svg"
  categories    = ["library", "security"]

  opengraph {
    title       = "AbuseIPDB Mod for Flowpipe"
    description = "Run pipelines to supercharge your AbuseIPDB workflows using Flowpipe."
    image       = "/images/mods/turbot/abuseipdb-social-graphic.png"
  }

  require {
    flowpipe {
      min_version = "1.0.0"
    }
  }
}
